from flask import Flask, request, jsonify
import numpy as np
import joblib
import os
import logging

# Initialize Flask app
app = Flask(__name__)

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Load the trained Q-table
model_path = 'q_table.pkl'

# Ensure the model file exists
if not os.path.exists(model_path):
    raise FileNotFoundError(f"{model_path} not found. Ensure the file is available in the directory.")

q_table = joblib.load(model_path)

# Global variables
state_size = 100
action_size = 100

# =========================================================
# SMART SCORING ENGINE
# =========================================================

def calculate_goal_score(goal_data):

    priority = goal_data.get("priority", 3)

    amount = goal_data.get("amount", 1)

    remaining = goal_data.get("remaining", 0)

    # ---------------------------------------------
    # PRIORITY SCORE
    # ---------------------------------------------

    priority_score = (6 - priority) * 20

    # ---------------------------------------------
    # URGENCY SCORE
    # More remaining means more urgency
    # ---------------------------------------------

    remaining_ratio = remaining / amount

    urgency_score = remaining_ratio * 40

    # ---------------------------------------------
    # COMPLETION BOOST
    # Near completion goals get boost
    # ---------------------------------------------

    completion = 1 - remaining_ratio

    completion_boost = 0

    if completion >= 0.8:
        completion_boost = 25

    elif completion >= 0.5:
        completion_boost = 10

    # ---------------------------------------------
    # FINAL SCORE
    # ---------------------------------------------

    total_score = (
        priority_score +
        urgency_score +
        completion_boost
    )

    return total_score

# =========================================================
# SMART ALLOCATION ENGINE
# =========================================================

def smart_allocate(goals):

    scores = []

    for goal_name, goal_data in goals.items():

        score = calculate_goal_score(goal_data)

        scores.append(score)

    total_score = sum(scores)

    if total_score == 0:
        return [100 / len(goals)] * len(goals)

    percentages = []

    for score in scores:

        percentage = (score / total_score) * 100

        percentages.append(round(percentage, 1))

    return percentages

# =========================================================
# NORMALIZE PERCENTAGES
# Ensures total always becomes 100
# =========================================================

def normalize_percentages(percentages):

    total = sum(percentages)

    if total == 0:
        return percentages

    normalized = [
        round((p / total) * 100, 1)
        for p in percentages
    ]

    # Fix rounding drift
    drift = 100 - sum(normalized)

    normalized[0] += drift

    return normalized


# Helper: Get state from remaining amounts and progress
def get_state(goals):
    total_remaining = sum(data["remaining"] for data in goals.values())
    avg_progress = np.mean([1 - (data["remaining"] / data["amount"]) for data in goals.values()])
    return min(int((total_remaining / 1000 + avg_progress * 10) // 1), state_size - 1)

# Generate dynamic percentages
def generate_percentages(num_goals, priorities, remaining_ratios, action_idx):
    weights = [1 / p * r for p, r in zip(priorities, remaining_ratios)]
    total_weight = sum(weights)
    base = [100 * (w / total_weight) if total_weight > 0 else 100 / num_goals for w in weights]
    perturbation = (action_idx - 50) * 0.3
    adjusted = []
    for i, b in enumerate(base):
        if i == 0:
            adj = b + perturbation
        else:
            adj = b - perturbation / (num_goals - 1)
        adjusted.append(max(5, min(80, adj)))
    total = sum(adjusted)
    return [round(a * 100 / total, 1) for a in adjusted] if total > 0 else [100 / num_goals] * num_goals

# # Get suggestion
# def get_suggestion(goals, savings):
#     state = get_state(goals)
#     best_action_idx = np.argmax(q_table[state])
#     priorities = [data["priority"] for data in goals.values()]
#     remaining_ratios = [data["remaining"] / data["amount"] for data in goals.values()]
#     return generate_percentages(len(goals), priorities, remaining_ratios, best_action_idx)
# =========================================================
# HYBRID SUGGESTION ENGINE
# Combines RL + Smart Logic
# =========================================================

def get_suggestion(goals, savings):

    try:

        # -------------------------------------------------
        # EXISTING RL OUTPUT
        # -------------------------------------------------

        state = get_state(goals)

        best_action_idx = np.argmax(q_table[state])

        priorities = [
            data["priority"]
            for data in goals.values()
        ]

        remaining_ratios = [
            data["remaining"] / data["amount"]
            for data in goals.values()
        ]

        rl_percentages = generate_percentages(
            len(goals),
            priorities,
            remaining_ratios,
            best_action_idx
        )

        # -------------------------------------------------
        # NEW SMART OUTPUT
        # -------------------------------------------------

        smart_percentages = smart_allocate(goals)

        # -------------------------------------------------
        # HYBRID MERGING
        # 80% smart logic
        # 20% RL influence
        # -------------------------------------------------

        final_percentages = []

        for rl, smart in zip(
            rl_percentages,
            smart_percentages
        ):

            combined = (
                smart * 0.8 +
                rl * 0.2
            )

            final_percentages.append(combined)

        # -------------------------------------------------
        # FINAL NORMALIZATION
        # -------------------------------------------------

        final_percentages = normalize_percentages(
            final_percentages
        )

        return final_percentages

    except Exception as e:

        logging.error(
            "Hybrid suggestion error: %s",
            e
        )

        # Safe fallback
        return smart_allocate(goals)

@app.route('/suggest', methods=['POST'])
def suggest():
    try:
        # Parse JSON input
        data = request.json

        # Log the received input data
        logging.info("Received input data: %s", data)

        # Extract fields from JSON
        savings = data['income']
        goals_data = data['goals']

        # Validate input
        if not goals_data or len(goals_data) < 2:
            raise ValueError("At least two goals are required.")

        # Create goals dictionary
        goals = {}
        for goal in goals_data:
            name = goal['goalName']
            if goal['remainingAmount'] > goal['targetAmount']:
                raise ValueError(f"Remaining amount for {name} exceeds target amount.")
            goals[name] = {
                'priority': goal['priority'],
                'amount': goal['targetAmount'],
                'remaining': goal['remainingAmount']
            }

        # Log the goals
        logging.info("Goals: %s", goals)

        # Get suggestion
        percentages = get_suggestion(goals, savings)

        # Format response
        response = {}
        for goal, percent in zip(goals.keys(), percentages):
            amount = savings * (percent / 100)
            response[goal] = {'percentage': percent, 'amount': round(amount, 2)}

        # Log the suggestion
        logging.info("Suggestion: %s", response)

        return jsonify(response)

    except KeyError as e:
        logging.error("KeyError: Missing field in request: %s", e)
        return jsonify({'error': f"Missing field in request: {e}"}), 400
    except ValueError as e:
        logging.error("ValueError: %s", e)
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        logging.error("Exception: %s", e)
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)