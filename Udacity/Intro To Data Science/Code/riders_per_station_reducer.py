import sys

def reducer():
    
    entries = 0
    old_key = None

    for line in sys.stdin:
        data = line.strip().split("\t")

        if len(data) != 2:
            continue
        
        this_key, count = data
        if old_key and old_key != this_key:
            print "{0}\t{1}".format(old_key, entries)
            entries = 0

        old_key = this_key
        entries += float(count)

    print "{0}\t{1}".format(old_key, entries)


reducer()