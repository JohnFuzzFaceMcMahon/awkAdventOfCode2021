

BEGIN {
    q="\"";
    debugFlag=1;
}

{
    # read everything into the inputRecord array
    inputRecord[NR]=$0;
}

# Debug Printing
# 
# dpx - String to be printed
# dpy - Unique number to put on the front of the message
# dpz - Flag to do printing
#
function dp( dpx, dpy, dpz ) {
        if (dpz) printf("###%05.5dDEBUG: %s\n",dpy,dpx);
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
    dp("currentPolymer is " q currentPolymer q,1000,debugFlag); 
    # nothing in line 2
    # pair insertion rules
    for (i=3;i<NR+1;i++) {
        split(inputRecord[i],smallArray," ");
        polymerPair=smallArray[1];
        # The "->" is in position 2
        polymerInsertion=smallArray[3];
        # stash in the array
        piArray[ polymerPair ]=polymerInsertion;
        dp("piArray[" polymerPair "] is " piArray[ polymerPair ],2000,0); 
    }
    # newPolymer=currentPolymer;
    newPolymer="";
    for (j=1;j<40+1;j++) {
        # perform insertion
        dp("step j=" j,3000,0);
        dp("current polymer " q currentPolymer q,4000,0);
        stopThis=0;
        for (;stopThis==0;) {
            printf("A1 ");
            dp("\ttop of the infinite loop",4100,0);
            polymerFront=substr(currentPolymer,1,1);
            printf("A1.1 ");
            dp("\tfront is " q polymerFront q,4200,0);
            printf("A2 ");
            if (polymerFront=="") {
                # this really shouldn't fire
                stopThis=1;
                dp("\tred signal 1",4500,0);
                continue;
            }
            printf("A3 ");
            dp("\tnew polymer " newPolymer,4249,0);
            newPolymer=newPolymer polymerFront;
            printf("A4 ");
            dp("\tnew polymer " newPolymer,4250,0);
            polymerBack=substr(currentPolymer,2,1);
            dp("\tback is " q polymerBack q,4300,0);
            printf("A5 ");
            if (polymerBack=="") {
                stopThis=1;
                dp("- red signal 2",4600,0);
                continue;
            }
            printf("A6 ");
            dp("\tgreen signal",4700,0);
            currentPair=polymerFront polymerBack;
            dp("\tcurrent pair " q currentPair q,5000,0);
            printf("A7 ");
            if ( piArray[currentPair]!="" ) {
                dp("\t\tmatch! add " piArray[currentPair],6000,0);
                pInsert=piArray[currentPair];
                newPolymer=newPolymer pInsert;
            }
            printf("A8 ");
            dp("\tnew polymer " newPolymer,6500,0);
            currentPolymer=substr(currentPolymer,2);
            dp("\tbottom of the infinite loop",7000,0);
            printf("A9 " j " " ++ugh " " length(currentPolymer) );
            print "";
        }
        dp("end step " j " new polymer length is " length(newPolymer) " currentPolymer length is " length(currentPolymer),8000,debugFlag);
        if ( newPolymer=="NCNBCHB" )                                                dp("using test data - step 1 result matches ",8000,debugFlag);
        if ( newPolymer=="NBCCNBBBCBHCB" )                                          dp("using test data - step 2 result matches ",8000,debugFlag);
        if ( newPolymer=="NBBBCNCCNBBNBNBBCHBHHBCHB" )                              dp("using test data - step 3 result matches ",8000,debugFlag);
        if ( newPolymer=="NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB" )      dp("using test data - step 4 result matches ",8000,debugFlag);      
        currentPolymer=newPolymer;
        newPolymer="";
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