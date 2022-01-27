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
    for (j=1;j<40+1;j++) {
        # perform insertion
        "date +%s" | getline startTime; close("date +%s");
        print "step " j " at " startTime;
        lastTime=startTime;
        # print "- current and new polymer " currentPolymer;
        zeeZeeZee=0;
        for (i=1;i<length(currentPolymer);i++) {
            currentPair = substr(currentPolymer,i,2);
            # cute crap...
            testTestTest=max(1,int( length(currentPolymer)*10/100 ));
            if ( (i%testTestTest)==0 ) {
                zeeZeeZee=zeeZeeZee+10;
                "date +%s" | getline currentTime; close("date +%s");
                print zeeZeeZee "% " i " time since last mark " currentTime-lastTime "s";
                print zeeZeeZee "% " i " speed " i / max(1,currentTime-startTime) " pair checks per second ";
                lastTime=currentTime;
            }
            # print "- current pair " currentPair;
            if ( piArray[currentPair]!="" ) {
                # print "-- match! add " piArray[currentPair];
                delta=length(newPolymer)-length(currentPolymer);
                polymerFront=substr(newPolymer,1,i+delta);
                polymerBack=substr(newPolymer,i+delta+1);
                newPolymer = polymerFront piArray[currentPair] polymerBack;
            }
            # print "- new polymer " newPolymer;
        }
        currentPolymer=newPolymer;
        "date +%s" | getline endTime; close("date +%s");
        print "end step " j " polymer length is " length(currentPolymer) " time for step " endTime-startTime "s";
        # test data checks
        if (0) {
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
    print "PART TWO ANSWER: " overallMax-overallMin; 
}