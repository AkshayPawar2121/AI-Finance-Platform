# train_model.py — Trains the budget prediction model and saves model.pkl
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score
import joblib
import os

def train_model():
    try:
        csv_path = os.path.join(os.path.dirname(__file__), 'sample.csv')
        print(f"Loading dataset from: {csv_path}")
        data = pd.read_csv(csv_path)

        print(f"Dataset loaded: {data.shape[0]} rows, {data.shape[1]} columns")
        print(f"Columns: {list(data.columns)}")

        # Input and output columns
        input_columns = ['Income', 'Age', 'Dependents', 'Occupation', 'City_Tier', 'Loan_Repayment', 'Insurance']
        output_columns = ['Rent', 'Groceries', 'Transport', 'Eating_Out', 'Entertainment',
                          'Utilities', 'Healthcare', 'Education', 'Desired_Savings']

        # Encode categorical variables
        data['City_Tier'] = data['City_Tier'].map({'Tier_1': 1, 'Tier_2': 2, 'Tier_3': 3})
        data['Occupation'] = data['Occupation'].astype('category').cat.codes

        # Drop rows with NaN in required columns
        data = data.dropna(subset=input_columns + output_columns)

        X = data[input_columns]
        y = data[output_columns]

        print(f"Training on {len(X)} samples with {len(output_columns)} output labels...")

        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        model = RandomForestRegressor(n_estimators=100, random_state=42, n_jobs=-1)
        model.fit(X_train, y_train)

        # Evaluation
        y_pred = model.predict(X_test)
        mse = mean_squared_error(y_test, y_pred)
        rmse = np.sqrt(mse)
        r2 = r2_score(y_test, y_pred)
        print(f"\n=== Model Training Complete! ===")
        print(f"RMSE:     {rmse:.2f}")
        print(f"R² Score: {r2:.4f}")

        # Save the model
        model_path = os.path.join(os.path.dirname(__file__), 'model.pkl')
        joblib.dump(model, model_path)
        print(f"Model saved as: {model_path}")

    except FileNotFoundError as e:
        print(f"Error: {e}")
        print("Please ensure 'sample.csv' is in the same directory as this script.")
    except Exception as e:
        import traceback
        print(f"An error occurred: {e}")
        traceback.print_exc()

if __name__ == '__main__':
    train_model()