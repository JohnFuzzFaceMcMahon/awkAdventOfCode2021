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

# Debug Printing
# 
# dpx - String to be printed
# dpy - Unique number to put on the front of the message
# dpz - Flag to do printing
#
function dp( dpx, dpy, dpz ) {
        if (dpz) printf("###%05.5dDEBUG: %s\n",dpy,dpx);
}

function showGrid(maxj,maxi,    howManyDots,i,j,k,printGreen,printReset,printBlue,printMagenta,printUnknown) {
    # maxj is the largest value for columns 
    # maxi is the largest value for rows
    # the rest are internal variables

    howManyDots=0;

    # Colors
    printBlue   ="\x1B[97m\x1B[104m";
    printGreen  ="\x1B[30m\x1B[102m";
    printMagenta="\x1B[30m\x1B[105m";
    printUnknown="\x1B[30m\x1B[103m";
    printReset="\x1B[0m";

    dp("maxi is " maxi,100,0);
    dp("maxj is " maxj,120,0);

    # header
    printf("       ");
    for (k=0;k<maxj+1;k++) {
        printf("%s%4.4X%s   ",printGreen,k,printReset);
    }   
    print "";

    printf("     +");
    for (k=0;k<maxj+1;k++) {
        printf("------+");
    }
    print "";
    # i is row (Y)
    for (i=0;i<maxi+1;i++) {
        # j is column (X)
        printf("%s%4.4X%s | ",printBlue,i,printReset);
        for (j=0;j<maxj+1;j++) {
            dp("maxj is " maxj " j is " j,140,0);
            if ( grid[j "|" i] > 0 ) {
                howManyDots++;
                if ( grid[j "|" i] > 1 ) {
                    printf("%s%4.4d%s | ", printUnknown,grid[j "|" i],printReset);
                } else {
                    printf("%s%4.4d%s | ", printMagenta,grid[j "|" i],printReset);
                }
            } else {
                printf("%4.4d | ", grid[j "|" i]);
            }
        }
        printf("%s%4.4X%s\n",printBlue,i,printReset);
        printf("     +");
        for (k=0;k<maxj+1;k++) {
            printf("------+");
        }
        print "";
    }
    # footer
    printf("       ");
    for (k=0;k<maxj+1;k++) {
        printf("%s%4.4X%s   ",printGreen,k,printReset);
    }   
    print ""; print "";
    print "There are " howManyDots " dots"
}

BEGIN {
    debugFlag=1;

    q = "\"";
    maxX=-1;
    maxY=-1;
}

{
    # read the file in
    inputArray[NR]=$0;
    dp("input array index " NR " value is " q inputArray[NR] q,200,0);
    # if it a X,Y pair shove it in the grid
    # is the first character a number?
    if ( substr(inputArray[NR],1,1) ~ "[0-9]" ) {
        split(inputArray[NR],parseArray,",");
        x=parseArray[1]; maxX=max(x,maxX); dp("x is " x " maxX is " maxX,220,0);
        y=parseArray[2]; maxY=max(y,maxY); dp("y is " y " maxY is " maxY,240,0);
        grid[x"|"y]=1;
    }
}

function foldUp(fuYValue,       fuRow,fuTargetRow,fuX) {
    # The row above the fold
    fuTargetRow=fuYValue-1;
    # The row below the fold
    fuRow=fuYValue+1;

    # walking down Y
    for(;fuRow<maxY+1;fuRow++) {
        dp("fuRow " fuRow,600,0);
        dp("fuTargetRow " fuTargetRow,610,0);
        # walking along X
        for (fuX=0;fuX<maxX+1;fuX++) {
            dp("fuX " fuX,620,0);
            # add the row value grid[fuX"|"fuRow] to the target row value grid[fuX"|"fuTargetRow] and store in target row grid[fuX"|"fuTargetRow]
            grid[fuX"|"fuTargetRow]=grid[fuX"|"fuTargetRow]+grid[fuX"|"fuRow];
            # zero out the "old" location
            grid[fuX"|"fuRow]=0;
        }
        # back off the target row 
        fuTargetRow--; 
    }
    # adjust maxY
    maxY=fuYValue-1;
}

function foldLeft(fuXValue,       fuCol,fuTargetCol,fuY) {
    # The col to the left the fold
    fuTargetCol=fuXValue-1;
    # The col to the right the fold
    fuCol=fuXValue+1;

    # walking down X
    for(;fuCol<maxX+1;fuCol++) {
        dp("fuCol " fuCol,1600,0);
        dp("fuTargetCol " fuTargetRow,1610,0);
        # walking along Y
        for (fuY=0;fuY<maxY+1;fuY++) {
            dp("fuY " fuY,1620,0);
            # add the row value grid[fuX"|"fuRow] to the target row value grid[fuX"|"fuTargetRow] and store in target row grid[fuX"|"fuTargetRow]
            grid[fuTargetCol"|"fuY]=grid[fuTargetCol"|"fuY]+grid[fuCol"|"fuY];
            # zero out the "old" location
            grid[fuCol"|"fuY]=0;
        }
        # back off the target row 
        fuTargetCol--; 
    }
    # adjust maxY
    maxX=fuXValue-1;
}

END {
    print "Initial State";
    print "";
    showGrid(maxX,maxY);
    print "";
    # look for commands
    for (i=1;i<NR+1;i++) {
        dp("i is " i,700,0);
        split(inputArray[i],workArray," ");
        if ( workArray[1]=="fold") {
            axis=workArray[3];
            sub("=.*","",axis);
            value=workArray[3];
            sub(".*=","",value);
            dp("command is " q inputArray[i] q,400,0)
            dp("axis is " axis " value is " value,425,0);
            if (axis=="y") foldUp(value);
            if (axis=="x") foldLeft(value);
            print "after " inputArray[i];
            print "";
            showGrid(maxX,maxY);
            print "";
            # only do one command
            exit;
        }
    }
}
