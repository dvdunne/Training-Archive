import sys

def mapper():

    for line in sys.stdin:
        data = line.strip().split(",")
        if data[0] == '':
            continue
        if data[1] == 'R170':
            print "{0}\t{1}".format(data[3], data[6]) 

mapper()