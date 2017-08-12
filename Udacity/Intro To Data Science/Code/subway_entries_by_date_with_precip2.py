import numpy as np
import pandas
import matplotlib.pyplot as plt
import datetime


def build_by_date_dataframe(dataframe):
    #group by date and sum entries and get the mean precipitation 
    sum_entries_per_day = dataframe.groupby(["DATEn"], as_index=False).sum()
    mean_entries_per_day = dataframe.groupby(["DATEn"], as_index=False).mean()
    df = sum_entries_per_day[['DATEn', 'ENTRIESn_hourly']]
    df.columns = ['Date' , 'Total_Entries']
    df['Mean_Precip'] = mean_entries_per_day['precipi']
    return df

def subway_entries_per_day(df):

    df = build_by_date_dataframe(df)
  
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    ax1.xaxis_date()
    ax1.set_title('Total Subway Riders & Mean Precipitation per Day')
    fig.autofmt_xdate()


    data = df[['Date', 'Total_Entries', 'Mean_Precip']]
    dates = df['Date']
    date_array = []

    for x in dates:
        date_object = datetime.datetime.strptime(x, "%Y-%m-%d")
        date_array.append(date_object.strftime('%m-%d-%y'))
        

    data['date_formatted'] =  np.array(date_array)
    data.columns =  ['Date', 'Total Entries' , 'Precipitation', 'Formatted Date']
    
    # Set up plot params
    plt.ylabel('# Riders', color='b')
    plt.xlabel('')
    width = 0.60

    # Plot Subway Entries
    ax1.bar(data['Formatted Date'], data['Total Entries'], width)

   # Plot Mean Riders
    mean_entries = np.mean(data['Total Entries'])
    plt.axhline(y=mean_entries, color='r', alpha = 0.6, linewidth='3', label='Mean')
    # ax1.text(0.05, 0.95, 'Mean Riders', color='r', alpha = 0.6)
    ax1.text(0.91, 0.83, 'Mean Riders', color='r', transform=ax1.transAxes, fontsize=12, verticalalignment='top')

    # PLot Precipitation
    ax2 = ax1.twinx()
    ax2.xaxis_date()
    ax2.set_ylim(0, 5)
    ax2.set_ylabel('Mean Precipitation per day', color='g')
    ax2.plot(data['Formatted Date'], data['Precipitation'], 'g-', linewidth='2')


    return plt, mean_entries


def main():
    df = pandas.read_csv('turnstile_data_master_with_weather.csv')
    p, mean_entries = subway_entries_per_day(df)
    print 'Mean Entries per Day : {0}'.format(mean_entries)
    p.show()

if __name__ == "__main__":
  main()
