import numpy as np
import joblib

# Global variables
state_size = 100  # Discretize state
action_size = 100  # Number of possible perturbations
q_table = np.zeros((state_size, action_size))

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
    perturbation = (action_idx - 50) * 0.3  # -15 to +15 range
    adjusted = []
    for i, b in enumerate(base):
        if i == 0:
            adj = b + perturbation
        else:
            adj = b - perturbation / (num_goals - 1)
        adjusted.append(max(5, min(80, adj)))  # Ensure 5% min, 80% max
    total = sum(adjusted)
    return [round(a * 100 / total, 1) for a in adjusted] if total > 0 else [100 / num_goals] * num_goals

# Reward function
def calculate_reward(goals, old_remaining, new_remaining):
    reward = 0
    for goal, data in goals.items():
        progress = (old_remaining[goal] - new_remaining[goal]) / data["amount"]
        remaining_ratio = new_remaining[goal] / data["amount"]
        if new_remaining[goal] == 0:
            reward += 10
        elif progress > 0.05 and data["priority"] <= 2:
            reward += 5
        elif progress > 0.05 and remaining_ratio < 0.2:
            reward += 3
        elif progress > 0.02:
            reward += 2
        elif progress == 0:
            reward -= 1
    return reward

# Train RL model
def train_model(goals, savings):
    global q_table
    episodes = 200
    epsilon = 0.2
    alpha = 0.1
    gamma = 0.9

    priorities = [data["priority"] for data in goals.values()]
    num_goals = len(goals)

    for _ in range(episodes):
        current_goals = {k: v.copy() for k, v in goals.items()}
        old_remaining = {k: v["remaining"] for k, v in current_goals.items()}
        state = get_state(current_goals)

        if np.random.random() < epsilon:
            action_idx = np.random.randint(action_size)
        else:
            action_idx = np.argmax(q_table[state])

        remaining_ratios = [data["remaining"] / data["amount"] for data in current_goals.values()]
        percentages = generate_percentages(num_goals, priorities, remaining_ratios, action_idx)
        allocations = [savings * (p / 100) for p in percentages]
        for i, goal in enumerate(current_goals.keys()):
            current_goals[goal]["remaining"] = max(0, current_goals[goal]["remaining"] - allocations[i])

        new_remaining = {k: v["remaining"] for k, v in current_goals.items()}
        reward = calculate_reward(current_goals, old_remaining, new_remaining)
        next_state = get_state(current_goals)
        q_table[state, action_idx] += alpha * (reward + gamma * np.max(q_table[next_state]) - q_table[state, action_idx])

    # Save the trained Q-table
    joblib.dump(q_table, 'q_table.pkl')
    print("Q-table saved as 'q_table.pkl'")

if __name__ == '__main__':
    # Example usage
    goals = {
        "car": {"priority": 1, "amount": 1000000, "remaining": 990000},
        "ksp": {"priority": 2, "amount": 15000, "remaining": 13800}
    }
    savings = 10000
    train_model(goals, savings)