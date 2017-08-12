import numpy as np
import pandas


def sum_entries_per_day(dataframe):
            #                 grouped.agg({'C' : np.sum,
            # 'D' : lambda x: np.std(x, ddof=1)})

    sum_entries_per_day = dataframe.groupby(["DATEn"], as_index=False).sum()
    mean_entries_per_day = dataframe.groupby(["DATEn"], as_index=False).mean()
    data = sum_entries_per_day[['DATEn', 'ENTRIESn_hourly']]
    data['Mean_Precip'] = mean_entries_per_day['precipi']
    print data



def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    df = df[['DATEn', 'ENTRIESn_hourly', 'precipi']]
    sum_entries_per_day(df)
    

if __name__ == "__main__":
  main()
