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

function showGrid(maxj,maxi,    i,j,k, printGreen, printReset) {
    # maxj is the largest value for columns 
    # maxi is the largest value for rows
    # the rest are internal variables

    # Colors
    printBlue   ="\x1B[97m\x1B[104m";
    printGreen  ="\x1B[30m\x1B[102m";
    printMagenta="\x1B[30m\x1B[105m";
    printReset="\x1B[0m";

    dp("maxi is " maxi,100,0);
    dp("maxj is " maxj,120,0);

    # header
    printf("       ");
    for (k=1;k<maxj+1;k++) {
        printf("%s%4.4X%s   ",printGreen,k,printReset);
    }   
    print "";

    printf("     +");
    for (k=1;k<maxj+1;k++) {
        printf("------+");
    }
    print "";
    # i is row (Y)
    for (i=1;i<maxi+1;i++) {
        # j is column (X)
        printf("%s%4.4X%s | ",printBlue,i,printReset);
        for (j=1;j<maxj+1;j++) {
            dp("maxj is " maxj " j is " j,140,0);
            if ( grid[j "|" i] > 0 ) {
                printf("%s%4.4d%s | ", printMagenta,grid[j "|" i],printReset);
            } else {
                printf("%4.4d | ", grid[j "|" i]);
            }
        }
        printf("%s%4.4X%s\n",printBlue,i,printReset);
        printf("     +");
        for (k=1;k<maxj+1;k++) {
            printf("------+");
        }
        print "";
    }
    # footer
    printf("       ");
    for (k=1;k<maxj+1;k++) {
        printf("%s%4.4X%s   ",printGreen,k,printReset);
    }   
    print "";
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

END {
    print "Initial State";
    print "";
    showGrid(maxX,maxY);
}