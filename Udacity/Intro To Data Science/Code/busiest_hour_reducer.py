import sys

def reducer():

    max_entries = 0
    old_key = None
    datetime = ''

    for line in sys.stdin:
        data = line.strip().split("\t")
        
        if len(data) != 4:
            continue
        
        this_key, entries, daten, timen = data
        # datetime = daten + " " + timen #init datetime

        if old_key and old_key != this_key:
            # datetime = daten + " " + timen        
            print "{0}\t{1}\t{2}".format(old_key, datetime, max_entries)
            max_entries = 0
        
        old_key = this_key
        if float(entries) >= float(max_entries):            
            max_entries = float(entries)
            datetime = daten + " " + timen
    
                
    print "{0}\t{1}\t{2}".format(old_key, datetime, max_entries)


reducer()