import numpy as np
import pandas
import matplotlib.pyplot as plt

def entries_histogram(turnstile_weather):
  
    plt.figure()

    turnstile_weather_no_rain  = turnstile_weather[turnstile_weather.rain == 1]
    turnstile_weather_rain = turnstile_weather[turnstile_weather.rain == 0]

    turnstile_weather_rain['ENTRIESn_hourly'].hist(color='b', bins=100, alpha=0.5)
    turnstile_weather_no_rain['ENTRIESn_hourly'].hist(color='r', bins=100, alpha=0.5)
    x_axis = [0, 10000, 0, 60000]
    plt.axis(x_axis)
    plt.xlabel('Entries')
    plt.ylabel('Freq')
    plt.legend(('Rain', 'No Rain'))
    plt.title('Subway Station Entries')


    return plt


def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    p = entries_histogram(df)
    p.show()

if __name__ == "__main__":
  main()
