import numpy as np
import pandas
import matplotlib.pyplot as plt
from datetime import datetime

def riders_per_station_histogram(riders_data):
    
    plt.figure()
    
    timen = riders_data['timen']
    hour_array = []

    for x in timen:
        date_object = datetime.strptime(x, "%H:%M:%S")
        hour_array.append(date_object.hour)
        
    riders_data['hour'] = np.array(hour_array)

    p1 = plt.bar(riders_data['hour'], riders_data['entries'], 1, color='lightblue')
    plt.ylabel('Entries')
    plt.xlabel('hour')
    plt.xlim([0,24])
    plt.xticks(np.arange(min(riders_data['hour']), max(riders_data['hour'])+1, 1.0))
    plt.title('Station R170 Entries')

    return plt


def main():
    df = pandas.read_csv('..\\output\\R170_entry_hour.csv')
    p = riders_per_station_histogram(df)
    p.show()

if __name__ == "__main__":
  main()
