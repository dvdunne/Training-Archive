import sys

def reducer():
    
    riders = 0
    old_key = None

    for line in sys.stdin:
        data = line.strip().split("\t")

        if len(data) != 2:
            continue
        
        this_key, count = data
        if old_key and old_key != this_key:
            riders = count

        old_key = this_key
        riders += float(count)

    print "0\t{0}".format(riders/31)

reducer()
