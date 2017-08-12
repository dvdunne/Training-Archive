import pandas
from ggplot import *

def riders_per_station_histogram(riders_data):

    units = riders_data['UNIT']
    uniti_array = []
    
    for x in units:
        uniti_array.append(x[1:])
    riders_data['uniti'] = np.array(uniti_array)
    turnstile_unit = riders_data[['uniti', 'Riders']]
    plot = ggplot(turnstile_unit, aes('uniti', 'Riders')) + geom_point(color = 'b') + ggtitle('Subway Entries per Station') + xlab('Station (Unit)') + ylab('Entries') + xlim(0, 600) + ylim(0, 3000000)
    return plot


def main():
    df = pandas.read_csv('..\\output\\riders_per_station_output.csv')
    print riders_per_station_histogram(df)
    
if __name__ == "__main__":
  main()
