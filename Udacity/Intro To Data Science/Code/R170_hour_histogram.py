import pandas
from ggplot import *

def hour_historgram(turnstile_data):

    R170_entries = turnstile_data[turnstile_data.UNIT == 'R170']
    units = R170_entries['UNIT']
    uniti_array = []
    
    for x in units:
        uniti_array.append(x[1:])
    R170_entries['uniti'] = np.array(uniti_array)
    turnstile_unit = R170_entries[['uniti', 'ENTRIESn_hourly']]
    plot = ggplot(turnstile_unit, aes('ENTRIESn_hourly')) + geom_histogram(color = 'lightblue')
    return plot





def main():
    turnstile_data = pandas.read_csv('turnstile_data_master_with_weather.csv')
    print hour_historgram(turnstile_data)

if __name__ == "__main__":
  main()