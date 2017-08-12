import sys
import string

def mapper():

    for line in sys.stdin:
        data = line.strip().split(",")
        if data[0] == '':
            continue
        print "0\t{0}".format(data[6]) 

mapper()
