import numpy as np
import pandas

def entries_total_mean(turnstile_weather):
    total_entries = 0
    for x in turnstile_weather['ENTRIESn_hourly']:
        total_entries += x



    mean_entries = np.mean(turnstile_weather['ENTRIESn_hourly'])

    return mean_entries, total_entries

def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    print entries_total_mean(df)

if __name__ == "__main__":
  main()
