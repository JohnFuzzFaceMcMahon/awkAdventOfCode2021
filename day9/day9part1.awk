BEGIN {
    debugFlag=1;
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
                totalRiskLevel=thisRiskLevel+totalRiskLevel;
                print j "," i " is a low point depth " grid[j "|" i] " risk level " grid[j "|" i]+1;
            }
        }  
    }
    print "total risk level is " totalRiskLevel;
}