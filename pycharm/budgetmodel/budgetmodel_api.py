
# from flask import Flask, request, jsonify
# import pandas as pd
# import joblib
# import os
# import logging
#
# # Initialize Flask app
# app = Flask(__name__)
#
# # Set up logging
# logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
#
# # Load the trained model
# model_path = 'model.pkl'
#
# # Ensure the model file exists
# if not os.path.exists(model_path):
#     raise FileNotFoundError(f"{model_path} not found. Ensure the file is available in the directory.")
#
# model = joblib.load(model_path)
#
#
# @app.route('/predict', methods=['POST'])
# def predict():
#     try:
#         # Parse JSON input
#         data = request.json
#
#         # Log the received input data
#         logging.info("Received input data: %s", data)
#
#         # Extract fields from JSON
#         income = data['Income']
#         age = data['Age']
#         dependents = data['Dependents']
#         occupation = data['Occupation']  # Already numerical
#         city_tier = data['City_Tier']
#         loan_repayment = data['Loan_Repayment']
#         insurance = data['Insurance']
#
#         # Create input DataFrame
#         input_data = pd.DataFrame({
#             'Income': [income],
#             'Age': [age],
#             'Dependents': [dependents],
#             'Occupation': [occupation],  # Directly use the numerical occupation
#             'City_Tier': [city_tier],
#             'Loan_Repayment': [loan_repayment],
#             'Insurance': [insurance]
#         })
#
#         # Log the input DataFrame
#         logging.info("Input DataFrame: \n%s", input_data)
#
#         # Predict
#         prediction = model.predict(input_data).flatten()
#
#         # Log the prediction
#         logging.info("Prediction: %s", prediction)
#
#         # Format and return the response
#         expense_labels = ['Rent', 'Groceries', 'Transport', 'Eating Out', 'Entertainment',
#                           'Utilities', 'Healthcare', 'Education', 'Desired_Savings']
#         response = {label: pred for label, pred in zip(expense_labels, prediction)}
#         return jsonify(response)
#
#     except KeyError as e:
#         logging.error("KeyError: Missing field in request: %s", e)
#         return jsonify({'error': f"Missing field in request: {e}"}), 400
#     except Exception as e:
#         logging.error("Exception: %s", e)
#         return jsonify({'error': str(e)}), 400
#
#
# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5000)
from flask import Flask, request, jsonify
import pandas as pd
import joblib
import os
import logging

# Initialize Flask app
app = Flask(__name__)

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Load the trained model
model_path = 'model.pkl'

# Ensure the model file exists
if not os.path.exists(model_path):
    raise FileNotFoundError(f"{model_path} not found. Ensure the file is available in the directory.")

model = joblib.load(model_path)

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Parse JSON input
        data = request.json

        # Log the received input data
        logging.info("Received input data: %s", data)

        # Extract fields from JSON
        income = data['Income']
        age = data['Age']
        dependents = data['Dependents']
        occupation = data['Occupation']  # Already numerical
        city_tier = data['City_Tier']
        loan_repayment = data['Loan_Repayment']
        insurance = data['Insurance']
        own_house = data.get('Own_House', False)
        self_sufficient_food = data.get('Self_Sufficient_Food', False)
        no_transport = data.get('No_Transport', False)
        no_eating_out = data.get('No_Eating_Out', False)
        no_entertainment = data.get('No_Entertainment', False)
        no_utilities = data.get('No_Utilities', False)
        no_healthcare = data.get('No_Healthcare', False)
        no_education = data.get('No_Education', False)

        # Create input DataFrame
        input_data = pd.DataFrame({
            'Income': [income],
            'Age': [age],
            'Dependents': [dependents],
            'Occupation': [occupation],  # Directly use the numerical occupation
            'City_Tier': [city_tier],
            'Loan_Repayment': [loan_repayment],
            'Insurance': [insurance]
        })

        # Predict
        prediction = model.predict(input_data).flatten()

        # Apply exclusions (move amounts to Desired Savings)
        if own_house:
            prediction[8] += prediction[0]  # Move Rent to Desired Savings
            prediction[0] = 0  # Set Rent to 0

        if self_sufficient_food:
            prediction[8] += prediction[1]  # Move Groceries to Desired Savings
            prediction[1] = 0  # Set Groceries to 0

        if no_transport:
            prediction[8] += prediction[2]  # Move Transport to Desired Savings
            prediction[2] = 0  # Set Transport to 0

        if no_eating_out:
            prediction[8] += prediction[3]  # Move Eating Out to Desired Savings
            prediction[3] = 0  # Set Eating Out to 0

        if no_entertainment:
            prediction[8] += prediction[4]  # Move Entertainment to Desired Savings
            prediction[4] = 0  # Set Entertainment to 0

        if no_utilities:
            prediction[8] += prediction[5]  # Move Utilities to Desired Savings
            prediction[5] = 0  # Set Utilities to 0

        if no_healthcare:
            prediction[8] += prediction[6]  # Move Healthcare to Desired Savings
            prediction[6] = 0  # Set Healthcare to 0

        if no_education:
            prediction[8] += prediction[7]  # Move Education to Desired Savings
            prediction[7] = 0  # Set Education to 0

        # Log the prediction
        logging.info("Prediction: %s", prediction)

        # Format and return the response
        expense_labels = ['Rent', 'Groceries', 'Transport', 'Eating Out', 'Entertainment',
                          'Utilities', 'Healthcare', 'Education', 'Desired Savings']
        response = {label: pred for label, pred in zip(expense_labels, prediction)}
        return jsonify(response)

    except KeyError as e:
        logging.error("KeyError: Missing field in request: %s", e)
        return jsonify({'error': f"Missing field in request: {e}"}), 400
    except Exception as e:
        logging.error("Exception: %s", e)
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)