import numpy as np
import pandas
# import scipy
# import statsmodels
import matplotlib.pyplot as plt
from ggplot import *


def build_by_date_dataframe(dataframe):

    sum_entries_per_day = dataframe.groupby(["DATEn", "Hour"], as_index=False).sum()
    mean_entries_per_day = dataframe.groupby(["DATEn", "Hour"], as_index=False).mean()
    df = sum_entries_per_day[['DATEn', 'ENTRIESn_hourly']]
    df.columns = ['Date' , 'Total_Entries']
    df['Mean_Precip'] = mean_entries_per_day['precipi']
    df['Mean_Temp'] = mean_entries_per_day['meantempi']
    df['Mean_Windspeed'] = mean_entries_per_day['meanwindspdi']
    return df


def normalize_features(array):
   mu = array.mean()
   sigma = array.std()
   array_normalized = (array-mu)/sigma
   return array_normalized, mu, sigma

def compute_cost(features, values, theta):
   
    m = len(values)
    sum_of_square_errors = np.square(np.dot(features, theta) - values).sum()
    cost = sum_of_square_errors / (2*m)

    return cost

def gradient_descent(features, values, theta, alpha, num_iterations):
    m = len(values)
    cost_history = []

    for i in range(num_iterations):
        predicted = np.dot(features, theta)
        theta = theta -alpha / m * np.dot((predicted - values), features)

        cost = compute_cost(features, values, theta)
        cost_history.append(cost)

    return theta, pandas.Series(cost_history)

def predictions(dataframe):

    dataframe = build_by_date_dataframe(dataframe)
    features = dataframe[['Mean_Precip', 'Mean_Temp', 'Mean_Windspeed']]
    values = dataframe[['Total_Entries']]

    m = len(values)

    features, mu, sigma = normalize_features(features)
    features['ones'] = np.ones(m)
    
    features_array = np.array(features)
    values_array = np.array(values).flatten()

    print features_array
    print values_array
    
    alpha = 0.2 
    num_iterations = 1000 

    #Initialize theta, perform gradient descent
    theta_gradient_descent = np.zeros(len(features.columns))
    theta_gradient_descent, cost_history = gradient_descent(features_array, values_array, theta_gradient_descent,
                                                            alpha, num_iterations)

    predictions = np.dot(features_array, theta_gradient_descent)

    return predictions, dataframe

def show_plots(dataframe, predictions):
    plt.figure()  
    plt.scatter(dataframe['Total_Entries'], predictions, c='r')
    plt.xlabel('Actual Entries')
    plt.ylabel('Predicted Entries')
    plt.title('Predicting Ridership using Linear Regression with Gradient Descent')
    return plt


def compute_r2(data, predictions):
        values = np.array(data[['Total_Entries']]).flatten()
        mean_value = np.mean(values)
        prediction = np.array(predictions).flatten()
        SSRes = np.sum((values-prediction)**2)
        SSTot = np.sum((values-mean_value)**2)

        return 1 - (SSRes/SSTot)


def plot_residuals(turnstile_weather, predictions):
   
    plt.figure()
    residuals = (turnstile_weather['Total_Entries'] - predictions)
    residuals_mean = np.mean(residuals)
    residuals_std = np.std(residuals)
    residuals.hist(color='blue', bins=100, alpha=0.5)
    the_axis = [-15000, 20000, 0, 40000]
    plt.axis(the_axis)
    plt.xlabel('Actual Hourly Entries - Predictions')
    plt.ylabel('Freq')
    plt.title('Linear Regression with Gradient Descent Residuals')

    return plt, residuals_mean, residuals_std


def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    prediction, dataframe = predictions(df)
    r2 = compute_r2(dataframe, prediction)
    print "Prediction = {0}\tR Squared = {1}".format(prediction, r2)
    plot = show_plots(dataframe, prediction)
    plot.show()

    # plt, res_mean, res_std = plot_residuals(dataframe, prediction)
    # print "Residuals Mean = {0}. Residuals Standard Deviation = {1}.".format(res_mean, res_std)
    # plt.show()


if __name__ == "__main__":
  main()
