import numpy as np
import pandas
import matplotlib.pyplot as plt
import datetime

def subway_entries_per_day(df):
  
    plt.figure()
    data = df[['DATEn', 'ENTRIESn_hourly', 'precipi']]

    dates = df['DATEn']
    date_array = []

    for x in dates:
        date_object = datetime.datetime.strptime(x, "%Y-%m-%d")
        date_array.append(date_object.strftime('%m-%d-%y'))
        

    data['date_formatted'] =  np.array(date_array)
    data.columns =  ['Date', 'Total Entries' , 'Precipitation', 'Formatted Date']
    data.plot(x = 'Formatted Date', y = 'Total Entries', kind = 'bar', title = "Subway Riders per Day", )
    plt.ylabel('# Riders')
    plt.xlabel('')

    mean_entries = np.mean(data['Total Entries'])
    plt.plot(data['Precipitation'], color='g')
    plt.axhline(y=mean_entries, color='r', alpha = 0.5)
    plt.text(28, mean_entries+10000, 'Mean', color='r', alpha = 0.5)

    return plt, mean_entries


def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    entries_by_date = df.groupby(["DATEn"], as_index=False).sum()
    p, mean_entries = subway_entries_per_day(entries_by_date)
    print 'Mean Entries per Day : {0}'.format(mean_entries)
    p.show()

if __name__ == "__main__":
  main()
