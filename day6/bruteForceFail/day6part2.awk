BEGIN {

}

function showFish() {
    for (sfIndex=1;sfIndex<countFish+1;sfIndex++) {
        printf("%s(%s) ",sfIndex,fish[sfIndex]);
    }
    print "";
}

# read in and parse the input data
{
    countFish=split($0,fish,",");
    print "Starting with " countFish " fish";
}

END {
    print "FOO";
    print "Initial State " countFish;
    # showFish();
    # end of day decrement
    for (day=1;day<256+1;day++) {
        # new fish time 
        for (i=1;i<countFish+1;i++) {
            if ( fish[i]==0 ) {
                # current fish starts the clock again
                fish[i]=6+1; # remember it will be decremented to six on this turn
                # create a new fish
                countFish++;
                fish[countFish]=8+1; # see above
            }
        }      
        # end of day
        for (i=1;i<countFish+1;i++) {
            fish[i]--;
        }
        # showFish();
        print "End Of Day " day " with " countFish " fish";
    }
    print "### TOTAL FISH: " countFish;
}
