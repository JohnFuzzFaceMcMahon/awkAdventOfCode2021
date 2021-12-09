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
}

END {
    printf( "Initial State:" );
    showFish();
    # end of day decrement
    for (day=1;day<80+1;day++) {
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
        printf("After Day %s: ",day);
        for (i=1;i<countFish+1;i++) {
            fish[i]--;
        }
        showFish();
    }
    print "### TOTAL FISH: " countFish;
}