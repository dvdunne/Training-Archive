import numpy as np
import scipy
import scipy.stats
import pandas

def shapiro_wilk_test(turnstile_weather):
    
    turnstile_weather_no_rain  = turnstile_weather[turnstile_weather.rain == 0]
    turnstile_weather_rain = turnstile_weather[turnstile_weather.rain == 1]

    entries_no_rain = np.array(turnstile_weather_no_rain['ENTRIESn_hourly'])
    entries_with_rain = np.array(turnstile_weather_rain['ENTRIESn_hourly'])

    W, p = scipy.stats.shapiro(turnstile_weather['ENTRIESn_hourly'])
    Wn,pn = scipy.stats.shapiro(entries_no_rain)
    Wr,pr = scipy.stats.shapiro(entries_with_rain)

    return W, p, Wn, pn, Wr, pr

def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    print shapiro_wilk_test(df)

if __name__ == "__main__":
  main()
