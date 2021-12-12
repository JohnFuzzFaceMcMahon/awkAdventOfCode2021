# Debug Print
function dp( dpx, dpy, dpz ) {
    # dpx - what we are printing
    # dpy - a number for message uniqueness (this message cam from HERE dang it)
    # dpz - flag for printing/not printing
    if (dpz) printf("###%05.5dDEBUG: %s\n",dpy,dpx);
}

BEGIN {
    debugFlag=0;
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
        # this array will contain the value of which basin a point is in 
        # we zero out the point
        basin[ NR "|" i ]=0;
        dp("setting " NR "|" i " to " thisDepth,300,debugFlag);
    }
}

function printBasin() {
    print "";
    for (pbj=0;pbj<NR+2;pbj++) {
        printf("%5s | ",pbj);
        # move along columns
        for (pbi=0;pbi<rowLength+2;pbi++) {
            if ( basin[ pbj "|" pbi ] == "") {
                printf("_ ");
            } else {
                printf("%s ",basin[ pbj "|" pbi ]);
            }
        # end column
        }
        print "|";
    # end row
    }
    print "";
}

END {
    print "";
    newBasin=0;
    # move along rows
    for (j=1;j<NR+1;j++) {
        # move along columns
        for (i=1;i<rowLength+1;i++) {
            # what is my depth here?
            printf("looking at point " j "," i " ");
            thisLocationDepth=grid[ j "|" i ];
            # part of a basin?
            if ( thisLocationDepth!=9 ) {
                currentBasin=0;
                # look at above right first  
                if ( int(basin[ j-1 "|" i+1 ])>0 ) {
                        # also make sure the next one to the right isn't a 9...
                        if ( grid[ j "|" i+1 ]!=9 ) {
                            print "/ " j-1 "," i+1 "=" basin[ j-1 "|" i+1 ]; 
                            currentBasin=basin[ j-1 "|" i+1 ];
                        } 
                }
                # OK, how about above?
                if ( (int(basin[ j-1 "|" i ])>0) && (currentBasin==0) ) {
                    print "^ " j-1 "," i "=" basin[ j-1 "|" i ]; 
                    currentBasin=basin[ j-1 "|" i ];
                }
                # finally look left
                if ( int(basin[ j "|" i-1 ])>0 && (currentBasin==0) ) {
                    print "< " j "," i-1 "=" basin[ j "|" i-1 ]; 
                    currentBasin=basin[ j "|" i-1 ];
                }
                # if we didn't find a basin...
                if ( currentBasin==0 ) {
                    print "$";
                    newBasin++;
                    currentBasin=newBasin;
                }
                basin[ j "|" i]=currentBasin;
            } else {
                print "X";
                basin[ j "|" i ]="X";
            }
            # printBasin();
        # end column
        }
    # end row
    }
    # printBasin();
    print "number of basins " currentBasin;
    # determine basin sizes
    print "";
    for (k=1;k<NR+1;k++) {
        # printf("%5s | ",k);
        # move along columns
        for (m=1;m<rowLength+1;m++) {
            if ( basin[ k "|" m ] == "") {
                # null result, shouldn't happen
                # printf("_ ");
            } else {
                # It is a ridgetop
                if ( basin[ k "|" m ] == "X") {
                    # printf("X ");
                } else {
                    # It is a basin
                    # printf("%s ",basin[ k "|" m ]);
                    # increment how many things are in the basin...
                    basinCount[ basin[ k "|" m ] ]++;
                }
            }
        # end column
        }
        # print "|";
    # end row
    }
    # print "";
    print "Basin totals";
    for (n=1;n<currentBasin+1;n++) {
        print n,basinCount[n];
    }
    # sort them
    didSort=1;
    for (; didSort==1 ;) {
        for (p=1;p<currentBasin;p++) {
            # do we need to sort?
            didSort=0;
            if ( basinCount[p]<basinCount[p+1]) {
                qqqqq=basinCount[p];
                basinCount[p]=basinCount[p+1];
                basinCount[p+1]=qqqqq;
                didSort=1;
            }
        }       
    }
    # what does it look like now?
    print "";
    print "Basin totals sorted";
    for (n=1;n<currentBasin+1;n++) {
        print n,basinCount[n];
    }   
    print "";
    print "ANSWER: " basinCount[1]*basinCount[2]*basinCount[3];
}