{
        sum+=$5
        if (NR==1) {
            min=$5
            max=$5
            min_name=$9
            max_name=$9
        }
        
        if ($5 > max) {
            max=$5
            max_name=$9
        }

        if ($5 < min) {
            min=$5
            min_name=$9
        }
    }
    END{
        print "Size: ", sum/1024 " KB"
        print "Files: ", NR
        if (stats==1) {
            print "Largest file:\t", max_name, max/1024, "KB"
            print "Smallest file:\t", min_name, min/1024, "KB"
        }
    }