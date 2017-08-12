import numpy as np
import scipy
import scipy.stats
import pandas

def mann_whitney_plus_means(turnstile_weather):
    
    turnstile_weather_no_rain  = turnstile_weather[turnstile_weather.rain == 0]
    turnstile_weather_rain = turnstile_weather[turnstile_weather.rain == 1]

    entries_no_rain = np.array(turnstile_weather_no_rain['ENTRIESn_hourly'])
    entries_with_rain = np.array(turnstile_weather_rain['ENTRIESn_hourly'])

    without_rain_mean = np.mean(entries_no_rain[~np.isnan(entries_no_rain)])
    with_rain_mean = np.mean(entries_with_rain[~np.isnan(entries_with_rain)])

    U,p = scipy.stats.mannwhitneyu(entries_no_rain, entries_with_rain)

    return with_rain_mean, without_rain_mean, U, p

def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    print mann_whitney_plus_means(df)

if __name__ == "__main__":
  main()
