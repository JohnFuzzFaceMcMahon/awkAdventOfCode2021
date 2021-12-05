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

function printPlot() {
    # print the plot array
    # return the current max
    ppCurrentMax=0;
    printf("    ");
    for (ppj=0;ppj<maxX+1;ppj++) {
        printf ppj%10;
    } 
    print "";
    for (ppi=0;ppi<maxY+1;ppi++) {
        printf("%4s",ppi)
        for (ppj=0;ppj<maxX+1;ppj++) {
            if ( plot[ppj "," ppi] == 0 ) {
                printf(".");
            } else {
                printf("%s", plot[ppj "," ppi]);
            }
            ppCurrentMax=max(ppCurrentMax,plot[ppj "," ppi])
        }
        print "";
    }
    return ppCurrentMax;
}

BEGIN {
    maxX=0;
    maxY=0;
}

# get it loaded
{
    # print "### NR " NR " $0 " $0;
    # use split to cut it up
    elementCount=split($0,inputArray,"[, ]");
    if (elementCount!=5) {
        print "### ZILCH elementCount " elementCount;
    }
    # for (i=1;i<elementCount+1;i++) {
    #    print i,inputArray[i];
    # }
    lineStart[NR "|X"]=inputArray[1]; maxX=max(inputArray[1],maxX);
    lineStart[NR "|Y"]=inputArray[2]; maxY=max(inputArray[2],maxY);
    lineEnd[NR   "|X"]=inputArray[4]; maxX=max(inputArray[4],maxX);
    lineEnd[NR   "|Y"]=inputArray[5]; maxY=max(inputArray[5],maxY);
}

END {
    # print "### maxX " maxX " maxY " maxY;
    # zero the plot array 
    for (i=0;i<maxY+1;i++) {
        for (j=0;j<maxX+1;j++) {
            plot[j "," i]="0";
        }
    }
    # print the plot array
    # printPlot();

    # for (x in plot) {
    #    print "YYY",x,plot[x];
    # }

    # plot horizontal lines
    for (i=1;i<NR+1;i++) {
        # print "### i " i;
        # print "### NR " NR;
        # if yes, a horizontal line
        if ( lineStart[i "|Y"]==lineEnd[i "|Y"] ) {
            # print "### horizontal line";
            saveY=lineStart[i "|Y"];
            # print "### saveY " saveY;
            xLineStart=min( lineStart[i "|X"], lineEnd[i "|X"] );
            # print "### xLineStart " xLineStart;
            xLineEnd=max( lineStart[i "|X"], lineEnd[i "|X"] );
            # print "### xLineEnd " xLineEnd;
            for(j=xLineStart;j<xLineEnd+1;j++) {
                # print "### Incrementing " j "," saveY;
                # print "### Was " plot[ j "," saveY ];
                plot[ j "," saveY ]=plot[ j "," saveY ]+1;
                # print "### Now " plot[ j "," saveY ];
            }
            # print "";
            # printPlot();
        } else {
            # print "ZZZ " lineStart[i "|X"] "," lineStart[i "|Y"] " to " lineEnd[i "|X"] "," lineEnd[i "|Y"];
        }
        # print "### i " i;
        # print "### NR " NR;
    } 

# plot vertical lines
    for (i=1;i<NR+1;i++) {
        # if yes, a vertical line
        if ( lineStart[i "|X"]==lineEnd[i "|X"] ) {
            saveX=lineStart[i "|X"];
            yLineStart=min( lineStart[i "|Y"], lineEnd[i "|Y"] );
            yLineEnd=max( lineStart[i "|Y"], lineEnd[i "|Y"] );\
            for(j=yLineStart;j<yLineEnd+1;j++) {
                plot[ saveX "," j ]=plot[ saveX "," j ]+1;
            }
            # print "";
            # printPlot();
        } else {
            # print "ZZZ " lineStart[i "|X"] "," lineStart[i "|Y"] " to " lineEnd[i "|X"] "," lineEnd[i "|Y"];
        }
    } 

    # print "### currentMax " currentMax;
    currentCrossoverCount=0;

    for (x in plot) {
        if ( plot[x]>1) { currentCrossoverCount++; }
    }
    print "";
    print "### currentCrossoverCount " currentCrossoverCount; 
}