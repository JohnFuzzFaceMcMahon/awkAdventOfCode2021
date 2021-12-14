BEGIN {
    q="\"";
}

{
    # read everything into the inputRecord array
    inputRecord[NR]=$0;
}

function max(mX1,mX2) {
    if (mX1>mX2) {
        return mX1;
    } else {
        return mX2;
    }
}

function min(nX1,nX2) {
    if (nX1>nX2) {
        return nX2;
    } else {
        return nX1;
    }
}

END {
    # template is the first thing in the file
    currentPolymer=inputRecord[1];
    # nothing in line 2
    # pair insertion rules
    for (i=3;i<NR+1;i++) {
        split(inputRecord[i],smallArray," ");
        polymerPair=smallArray[1];
        # The "->" is in position 2
        polymerInsertion=smallArray[3];
        # stash in the array
        piArray[ polymerPair ]=polymerInsertion;
    }
    newPolymer=currentPolymer;
    for (j=1;j<10+1;j++) {
        # perform insertion
        print "step " j;
        print "- current and new polymer " currentPolymer;
        for (i=1;i<length(currentPolymer);i++) {
            currentPair = substr(currentPolymer,i,2);
            print "- current pair " currentPair;
            if ( piArray[currentPair]!="" ) {
                print "-- match! add " piArray[currentPair];
                delta=length(newPolymer)-length(currentPolymer);
                polymerFront=substr(newPolymer,1,i+delta);
                polymerBack=substr(newPolymer,i+delta+1);
                newPolymer = polymerFront piArray[currentPair] polymerBack;
            }
            print "- new polymer " newPolymer;
        }
        currentPolymer=newPolymer;
        print "end step " j " polymer length is " length(currentPolymer);
        # test data checks
        if (1) {
                if (j==1) {
                    if ( currentPolymer=="NCNBCHB") { print "result OK"; } else { print "result BAD"; }
                }
                if (j==2) {
                    if ( currentPolymer=="NBCCNBBBCBHCB") { print "result OK"; } else { print "result BAD"; }
                }
                if (j==3) {
                    if ( currentPolymer=="NBBBCNCCNBBNBNBBCHBHHBCHB") { print "result OK"; } else { print "result BAD"; }
                }
                if (j==4) {
                    if ( currentPolymer=="NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB") { print "result OK"; } else { print "result BAD"; }
                }
        }
        # end of test data checks  
        print "";
    }
    # iterations finished

    # count the elements
    for (k=1; k<length(currentPolymer)+1; k++) {
        currentElement=substr(currentPolymer,k,1);
        elementCount[currentElement]++;
    }

    overallMax=0;
    overallMin=9999999999999999999999;
    # find the high and low
    for (l in elementCount) {
        print l,elementCount[l];
        overallMax=max(overallMax,elementCount[l]);
        overallMin=min(overallMin,elementCount[l])
    }
    print "PART ONE ANSWER: " overallMax-overallMin; 
}