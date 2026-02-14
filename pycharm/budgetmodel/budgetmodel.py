# # Import necessary libraries
# import pandas as pd
# import numpy as np
# from sklearn.model_selection import train_test_split
# from sklearn.ensemble import RandomForestRegressor
# from sklearn.metrics import mean_squared_error, r2_score
# import joblib
#
# # Function to train the model
# def train_model():
#     try:
#         # Load the dataset
#         data = pd.read_csv('sample.csv')  # Ensure sample.csv is in the same directory
#
#         # Selecting input and output columns
#         input_columns = ['Income', 'Age', 'Dependents', 'Occupation', 'City_Tier', 'Loan_Repayment', 'Insurance']
#         output_columns = ['Rent', 'Groceries', 'Transport', 'Eating_Out', 'Entertainment',
#                           'Utilities', 'Healthcare', 'Education', 'Desired_Savings']
#
#         # Encoding categorical variables
#         data['City_Tier'] = data['City_Tier'].map({'Tier_1': 1, 'Tier_2': 2, 'Tier_3': 3})
#         data['Occupation'] = data['Occupation'].astype('category').cat.codes  # Encode Occupation
#
#         # Splitting data into inputs and outputs
#         X = data[input_columns]
#         y = data[output_columns]
#
#         # Splitting into train and test sets
#         X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
#
#         # Training the model
#         model = RandomForestRegressor(random_state=42)
#         model.fit(X_train, y_train)
#
#         # Model evaluation
#         y_pred = model.predict(X_test)
#         mse = mean_squared_error(y_test, y_pred)
#         rmse = np.sqrt(mse)
#         r2 = r2_score(y_test, y_pred)
#         print(f"Model Training Complete!")
#         print(f"Mean Squared Error: {mse:.2f}")
#         print(f"Root Mean Squared Error: {rmse:.2f}")
#         print(f"R^2 Score: {r2:.2f}")
#
#         # Save the trained model
#         joblib.dump(model, 'model.pkl')
#         print("Model saved as 'model.pkl'")
#
#     except FileNotFoundError:
#         print("Error: Dataset 'sample.csv' not found. Please place the file in the same directory.")
#     except Exception as e:
#         print(f"An error occurred: {e}")
#
# if __name__ == '__main__':
#     train_model()



# Import necessary libraries
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score
import joblib

# Function to train the model
def train_model():
    try:
        # Load the dataset
        data = pd.read_csv('sample.csv')  # Ensure sample.csv is in the same directory

        # Selecting input and output columns
        input_columns = ['Income', 'Age', 'Dependents', 'Occupation', 'City_Tier', 'Loan_Repayment', 'Insurance']
        output_columns = ['Rent', 'Groceries', 'Transport', 'Eating_Out', 'Entertainment',
                          'Utilities', 'Healthcare', 'Education', 'Desired_Savings']

        # Encoding categorical variables
        data['City_Tier'] = data['City_Tier'].map({'Tier_1': 1, 'Tier_2': 2, 'Tier_3': 3})
        data['Occupation'] = data['Occupation'].astype('category').cat.codes  # Encode Occupation

        # Splitting data into inputs and outputs
        X = data[input_columns]
        y = data[output_columns]

        # Splitting into train and test sets
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        # Training the model
        model = RandomForestRegressor(random_state=42)
        model.fit(X_train, y_train)

        # Model evaluation
        y_pred = model.predict(X_test)
        mse = mean_squared_error(y_test, y_pred)
        rmse = np.sqrt(mse)
        r2 = r2_score(y_test, y_pred)
        print(f"Model Training Complete!")
        print(f"Mean Squared Error: {mse:.2f}")
        print(f"Root Mean Squared Error: {rmse:.2f}")
        print(f"R^2 Score: {r2:.2f}")

        # Save the trained model
        joblib.dump(model, 'model.pkl')
        print("Model saved as 'model.pkl'")

    except FileNotFoundError:
        print("Error: Dataset 'sample.csv' not found. Please place the file in the same directory.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == '__main__':
    train_model()