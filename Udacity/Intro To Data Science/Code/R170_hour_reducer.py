import sys

def reducer():

    total_entries = 0
    old_key = None

    for line in sys.stdin:
        data = line.strip().split("\t")
        
        if len(data) != 2:
            continue
        
        this_key, entries = data

        if old_key and old_key != this_key:   
            print "{0}\t{1}".format(old_key, total_entries)
            total_entries = 0
        
        old_key = this_key       
        total_entries += float(entries)
   
                
    print "{0}\t{1}".format(old_key, total_entries)

reducer()