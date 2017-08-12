import numpy as np
import pandas
# import scipy
# import statsmodels
import matplotlib.pyplot as plt
from ggplot import *


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
    dataframe = dataframe[dataframe.UNIT == 'R170']
    # dummy_units = pandas.get_dummies(dataframe['UNIT'], prefix='unit')
    features = dataframe[['precipi', 'meantempi', 'Hour', 'meanwindspdi', 'rain', 'mintempi', 'maxtempi', 'EXITSn_hourly']] #.join(dummy_units)
    values = dataframe[['ENTRIESn_hourly']]
    m = len(values)

    features, mu, sigma = normalize_features(features)
    features['ones'] = np.ones(m)
    
    features_array = np.array(features)
    values_array = np.array(values).flatten()

    print features_array
    print values_array
    

    #Set values for alpha, number of iterations.
    alpha = 0.1 # please feel free to play with this value
    num_iterations = 100 # please feel free to play with this value

    #Initialize theta, perform gradient descent
    theta_gradient_descent = np.zeros(len(features.columns))
    theta_gradient_descent, cost_history = gradient_descent(features_array, values_array, theta_gradient_descent,
                                                            alpha, num_iterations)

    predictions = np.dot(features_array, theta_gradient_descent)

    return predictions, dataframe


def show_plots(dataframe, predictions):
    slope, intercept = np.polyfit(dataframe['ENTRIESn_hourly'], predictions, 1)
    plt.figure()
    
    line = slope*dataframe['ENTRIESn_hourly']+intercept
   
    plt.scatter(dataframe['ENTRIESn_hourly'], predictions, c='r')
    plt.plot(dataframe['ENTRIESn_hourly'], line, 'b')
    x_axis = [-5000, 60000, -5000, 60000]
    plt.axis(x_axis)
    plt.xlabel('Actual Entries')
    plt.ylabel('Predicted Entries')
    plt.title('Predicting Ridership using Linear Regression with Gradient Descent (Station R170)')
    plt.legend(('Least squares polynomial fit', 'Subway Entries'))
    
    return plt


def compute_r2(data, predictions):
        values = np.array(data[['ENTRIESn_hourly']]).flatten()
        mean_value = np.mean(values)
        prediction = np.array(predictions).flatten()
        SSRes = np.sum((values-prediction)**2)
        SSTot = np.sum((values-mean_value)**2)

        return 1 - (SSRes/SSTot)


def plot_residuals(turnstile_weather, predictions):
   
    plt.figure()
    residuals = (turnstile_weather['ENTRIESn_hourly'] - predictions)
    residuals_mean = np.mean(residuals)
    residuals_std = np.std(residuals)
    residuals.hist(color='blue', bins=100, alpha=0.5)
    # the_axis = [-15000, 20000, 0, 40000]
    # plt.axis(the_axis)
    plt.xlabel('Actual Hourly Entries - Predictions')
    plt.ylabel('Freq')
    plt.title('Linear Regression with Gradient Descent Residuals (Station R170)')

    return plt, residuals_mean, residuals_std


def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    prediction, df = predictions(df)
    r2 = compute_r2(df, prediction)
    print "Prediction = {0}\tR Squared = {1}".format(prediction, r2)
    plot = show_plots(df, prediction)
    plot.show()

    plt, res_mean, res_std = plot_residuals(df, prediction)
    print "Residuals Mean = {0}. Residuals Standard Deviation = {1}.".format(res_mean, res_std)
    plt.show()


if __name__ == "__main__":
  main()
