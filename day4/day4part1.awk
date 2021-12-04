BEGIN {
    # print "### BEGIN";
    boardNumber=0;
    boardRow=0;
    q="\"";
}

{
    # print "### input line is " q $0 q ", NR is " q NR q ", NF is " q NF q;
    # first record contains the called numbers
    if (NR==1) {
        calledNumbersLength=split($0,calledNumbersArray,",");
        # print "### calledNumbersLength is " q calledNumbersLength q;
    } else {
        if (NF==0) {
            # no fields? start a new board
            boardNumber++;
            boardRow=0;
            # print "### new board " q boardNumber q;
            boardWon[boardNumber]=0;
            boardFinal[boardNumber]=0;
        } else {
            # row for the current board
            boardRow++;
            # print "### new row " q boardRow q " in board " q boardNumber q;
            for (i=1;i<6;i++) {
                # yup, a 3d array...
                board[boardNumber "|" boardRow "|" i]=$i;
                markedBoard[boardNumber "|" boardRow "|" i]=$i;
                # print "### board " q boardNumber q " row " q boardRow q " col " q i q " set to " q $i q;
            }
        }
    }
}

END {
    # print "### END";
    # break the loop when we have winners
    stopStopStop=0;
    # calling numbers loop
    # a is the index to calledNumbersArray
    for (a=1;a<calledNumbersLength+1;a++) {
        if (stopStopStop==1) {
            # print "### skipping number " q calledNumbersArray[a] q " array index " q a q;
            continue;
        }
        # print "### calling number " q calledNumbersArray[a] q " array index " q a q;
        # marking numbers loop
        # board
        for (b=1;b<boardNumber+1;b++){
            # row
            for (c=1;c<6;c++){
                # column
                for (d=1;d<6;d++){
                    if ( board[b"|"c"|"d]==calledNumbersArray[a] ) {
                        # print "### marking " markedBoard[b"|"c"|"d] " at " b "," c "," d;
                        markedBoard[b"|"c"|"d]="X";
                    } else {
                        # print "### not marking " markedBoard[b"|"c"|"d] " at " b "," c "," d;
                    }
                }
            }
        }
        # check for winning board loop
        for (b=1;b<boardNumber+1;b++){
            # print "### checking board " b;
            # horizontal check
            for (c=1;c<6;c++) {
                test="";
                for (d=1;d<6;d++){
                    test=test markedBoard[b"|"c"|"d];
                }
                if (test=="XXXXX") {
                    # print "### winning board " b " row " c " test " test;
                    stopStopStop=1;
                    # score the board
                    t=0;
                    for (e=1;e<6;e++) {
                        for (f=1;f<6;f++) {
                            if ( markedBoard[b"|"e"|"f]!="X" ) {
                                t=t+markedBoard[b"|"e"|"f];
                            }
                        }
                    }
                    print "### board total " t " last call " calledNumbersArray[a] " final score " t*calledNumbersArray[a] ;
                    if ( boardWon[b]==0 ) {
                        boardWon[b]=a;
                        boardFinal[b]=t*calledNumbersArray[a];
                    }
                } else {
                    # print "### nope board " b " row " c " test " test;
                }
            }
           # vertical check
            for (c=1;c<6;c++) {
                test="";
                for (d=1;d<6;d++){
                    test=test markedBoard[b"|"d"|"c];
                }
                if (test=="XXXXX") {
                   # print "### winning board " b " col " c " test " test;
                   stopStopStop=1;
                    # score the board
                    t=0;
                    for (e=1;e<6;e++) {
                        for (f=1;f<6;f++) {
                            if ( markedBoard[b"|"e"|"f]!="X" ) {
                                t=t+markedBoard[b"|"e"|"f];
                            }
                        }
                    }
                    print "### board total " t " last call " calledNumbersArray[a] " final score " t*calledNumbersArray[a] ;
                    if ( boardWon[b]==0 ) {
                        boardWon[b]=a;
                        boardFinal[b]=t*calledNumbersArray[a];
                    }
                } else {
                    # print "### nope board " b " col " c " test " test;
                }
            }
        }
    }
    testTestTest=0;
    for (b=1;b<boardNumber+1;b++) {
        if (boardWon[b]>testTestTest) {
            testTestTest=b;
        }
    }
    ### print "### FINAL ANSWER IS BOARD " b " WITH A SCORE OF " boardFinal[b];
}