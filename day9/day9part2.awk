BEGIN {
    debugFlag=0;
}

# Debug Print
function dp( dpx, dpy, dpz ) {
    # dpx - what we are printing
    # dpy - a number for message uniqueness (this message cam from HERE dang it)
    # dpz - flag for printing/not printing
    if (dpz) printf("###%05.5dDEBUG: %s\n",dpy,dpx);
}

{
    dp("$0 is " $0,100,debugFlag);
    rowLength=length($0);
    dp("row number " NR " rowLength is " rowLength,200,debugFlag);
    # put each depth in an array element
    for (i=1;i<rowLength+1;i++) {
        # i is the column
        # NR is the row
        thisDepth=substr($0,i,1);
        grid[ NR "|" i ]=thisDepth;
        dp("setting " NR "|" i " to " thisDepth,300,debugFlag);
    }
}

function evaluate(eeeCPX,eeeCPY,eeeAPX,eeeAPY,eeeDirection) {
    # test "eeeDirection" (eeeAPX,eeeAPY)
    # does the point exist?
    dp("current point is " eeeCPX "," eeeCPY " looking at " eeeDirection " at " eeeAPX "," eeeAPY,400,debugFlag);
    if ( grid[ eeeAPX "|" eeeAPY ] != "" ) {
                pointsAdjacentToThisLocation++;
                # is the adjacent point higher?
                if ( grid[ eeeAPX "|" eeeAPY ] > grid[ eeeCPX "|" eeeCPY ] ) {
                    thisLocationIsLowerThan++;
                }
            } else {
                dp("point " eeeAPX "," eeeAPY " is not valid",500,debugFlag);
            }    
}

function basinSize(bsX,bsY,bsContextX,bsContextY      ,bsCurrentDepth,bsA,bsB,bsC,bsD,bsT) {
    # print "basinSize " bsX "," bsY " called from " bsContextX "," bsContextY;
    bsCurrentDepth=grid[bsX "|" bsY];
    # did we do this one?
    if ( didWeDoThisOne[bsX "|" bsY]==1 ) {
        # print "basinSize " bsX "," bsY " returning ZERO because we saw it before";
        return 0;       
    } else {
        didWeDoThisOne[bsX "|" bsY]=1;
    }
    # A ridge
    if (bsCurrentDepth==9)  {
        # print "basinSize " bsX "," bsY " returning ZERO because it is a ridge";
        return 0;
    }
    # Off the graph
    if (bsCurrentDepth=="") {
        # print "basinSize " bsX "," bsY " returning ZERO because it is off the graph";
        return 0;
    }
    # look at our neighbors
    bsA=basinSize(bsX-1,bsY,bsX,bsY);
    bsB=basinSize(bsX+1,bsY,bsX,bsY);   
    bsC=basinSize(bsX,bsY-1,bsX,bsY);
    bsD=basinSize(bsX,bsY+1,bsX,bsY);
    bsT=1+bsA+bsB+bsC+bsD;
    # print "basinSize " bsX "," bsY " returning " bsT;
    return bsT;   
}

END {
    # look at each element

    # row increment
    for (j=1;j<NR+1;j++) {
        # column increment
        for (i=1;i<rowLength+1;i++) {
            thisLocationDepth=grid[ j "|" i ];
            # of the points checked, how many am I lower than?
            # a low point will have thisLocationIsLowerThan equal the value of pointsAdjacentToThisLocation
            thisLocationIsLowerThan=0; 
            # how many valid points are around me?
            pointsAdjacentToThisLocation=0;
            # test "up" (row-1,column)
            evaluate(j,i,j-1,i,"UP");
            dp( thisLocationIsLowerThan " of " pointsAdjacentToThisLocation,600,debugFlag );
            # test "down" (row+1,column)
            evaluate(j,i,j+1,i,"DOWN");
            dp( thisLocationIsLowerThan " of " pointsAdjacentToThisLocation,700,debugFlag );
            # test "left" (row,column-1)
            evaluate(j,i,j,i-1,"LEFT");
            dp( thisLocationIsLowerThan " of " pointsAdjacentToThisLocation,800,debugFlag );
            # test "right" (row,column+1)
            evaluate(j,i,j,i+1,"RIGHT");
            dp( thisLocationIsLowerThan " of " pointsAdjacentToThisLocation,900,debugFlag );
            # Is this a low point?
            if ( thisLocationIsLowerThan == pointsAdjacentToThisLocation ) {
                thisRiskLevel=grid[j "|" i]+1;
                lowPointArray[j "|" i]=1;
                totalRiskLevel=thisRiskLevel+totalRiskLevel;
                # print j "," i " is a low point depth " grid[j "|" i] " risk level " grid[j "|" i]+1;
            }
        }  
    }
    # print "total risk level is " totalRiskLevel;
    # print "";
    print "basin low points";
    ddSortArrayCount=0;
    for ( ddHere in lowPointArray ) {
        split(ddHere,ddArray,"|");
        ddX=ddArray[1];
        ddY=ddArray[2];
        ddSize=basinSize(ddX,ddY,-999,-999);
        ddSortArray[ddSortArrayCount]=ddSize;
        ddSortArrayCount++;
        print "x=" ddX " y=" ddY " size=" ddSize;
    }
    # ok, what is the answer?
    eeDidSort=1;
    for (; eeDidSort==1 ;) {
        eeDidSort=0;
        for(eeI=0;eeI<ddSortArrayCount-1;eeI++) {
            print eeI,ddSortArrayCount,ddSortArray[eeI],ddSortArray[eeI+1];
            if ( ddSortArray[eeI]<ddSortArray[eeI+1]) {
                eeDidSort=1;
                eeTemp=ddSortArray[eeI];
                ddSortArray[eeI]=ddSortArray[eeI+1];
                ddSortArray[eeI+1]=eeTemp;
                print "swap";
            }
        }
    }
    print "Top Three: " ddSortArray[0] "," ddSortArray[1] "," ddSortArray[2];
    print "Final Answer: " ddSortArray[0] * ddSortArray[1] * ddSortArray[2];
}