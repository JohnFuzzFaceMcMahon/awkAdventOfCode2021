BEGIN {
    for(i=0;i<10;i++) {
        # zero out the array
        # index is the "day", value is the number of fish on that day
        totalFish[i]=0;
    }
    # How many days will we run?
    howManyDays=256;
}

function showFish() {
    print "Cycle\t\tFish";
    print "-----\t\t----";
    # how many fish do we have total?
    sfCount=0;
    for(i=9;i>-1;i--) {
        # how many fish on just this day?
        print i "\t\t" totalFish[i];
        sfCount=sfCount+totalFish[i];
    }
    print "Total: " sfCount "\n";
}

# read in and parse the input data
{
    countFish=split($0,fish,",");
    for (i=0;i<countFish+1;i++) {
        totalFish[ fish[i] ]++;
    }
}

END {
    print "Initial State";
    showFish();
    # day loop
    for (day=1;day<howManyDays+1;day++) {
        print "After Day " day;
        # new fish
        totalFish[8+1]=totalFish[0];
        # restart clock on current fish
        totalFish[6+1]=totalFish[6+1]+totalFish[0];
        # move fish total to "tomorrow"
        for (i=0;i<10;i++) {
            totalFish[i]=totalFish[i+1];
        }
        showFish();
    }
}
