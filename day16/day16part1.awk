BEGIN {
    q="\"";
    # binary table
    if (1) {
        for (i=0;i<15+1;i++) {
            saveBin             ="";    # this will increase throughout the j loop
            saveDec             =i;     # this will decrease throughout the j loop
            saveHex             =sprintf("%x",saveDec);
            # print "----- i is " i;
            for (j=8;j>0;j=int(j/2)) {
                # print "j is " j
                testDec=int(saveDec/j);
                # print "testDec is " testDec;
                saveBin=saveBin testDec;
                # print "saveBin is " saveBin;
                if ( testDec==1 ) {
                    saveDec=saveDec-j;
                } 
                # print "saveDec is " saveDec;
            }
            hexNum2Bin[saveHex]=saveBin;            # hex to binary
            hexNum2Bin[toupper(saveHex)]=saveBin;   # hex to binary
            decNum2Bin[i]=saveBin;                  # decimal to binary
            bin2HexNum[saveBin]=saveHex;            # binary to hex
            bin2DecNum[saveBin]=i;                  # binary to decimal
        }
        # for (x in hexNum2Bin) {
        #    print "*",x,hexNum2Bin[x];
        # }
    }
}

function padBin(x,      y) {
    # fsck you Dr. M
    y="0000" x;
    return substr(y,length(y)-3,4);
}

function bin2Dec(x,     y,i,z) {
        y=length(x);
        for(i=1;i<y+1;i++) {
            z=z+int(substr(x,i,1)*2**(y-i));
        }
        return z;
}

function process(pPacket,        pPacketLength,pRemainingPacketLength,pVersionBin,pTypeBin,pKeepGoing,pCurrentPosition,pActualValueBin,pFlagBin,pValueBin,pActualValueDec,pLengthTypeId,pLengthBin,pLengthDec) {
    print "Hello " q pPacket q;
    # determine length
    pPacketLength=length(pPacket);
    pRemainingPacketLength=length(pPacket);
    print " pPacketLength " pPacketLength;
    # determine version (bits 1-3)
    pVersionBin=substr(pPacket,1,3); pRemainingPacketLength=pRemainingPacketLength-3;
    print " pVersionBin " pVersionBin;
    # pad to four bits
    pVersionBin=padBin(pVersionBin);
    print " pVersionBin " pVersionBin " (padded)";
    print " - pVersionBin b" pVersionBin " x" bin2HexNum[pVersionBin] " d" bin2DecNum[pVersionBin];
    # determine type (bits 4-6)
    pTypeBin=substr(pPacket,4,3); pRemainingPacketLength=pRemainingPacketLength-3;
    # pad to four 
    pTypeBin=padBin(pTypeBin);
    print " - pTypeBin    b" pTypeBin " x" bin2HexNum[pTypeBin] " d" bin2DecNum[pTypeBin];
    # type four packet... simple...
    if (pTypeBin=="0100") {
        # did we run out of values?
        pKeepGoing=1;
        # where are we in the bit stream
        pCurrentPosition=7;
        print " - value";
        # the subset of the bit stream that contains a flag (bit 7) and a number (bit 8-11)
        pActualValueBin="";
        for (; pKeepGoing==1; ) {
            # this chunk contains a flag bit and four bits of data
            pFlagBin=substr(pPacket,pCurrentPosition,1); pRemainingPacketLength=pRemainingPacketLength-1;
            pKeepGoing=int(pFlagBin);
            pValueBin=substr(pPacket,pCurrentPosition+1,4); pRemainingPacketLength=pRemainingPacketLength-4;
            print " -- pFlagBin " pFlagBin " b" pValueBin " x" bin2HexNum[pValueBin] " d" bin2DecNum[pValueBin];
            # move to the next chunk of data
            pCurrentPosition=pCurrentPosition+5;
            # add the binary to the total
            pActualValueBin=pActualValueBin pValueBin;
        }
        print " -- TYPE " pTypeBin " PACKET VALUE RESULT b" pActualValueBin;
        pActualValueDec=bin2Dec(pActualValueBin);
        print " -- TYPE " pTypeBin " PACKET VALUE RESULT d" pActualValueDec; 
        print " remaining cruft is " pRemainingPacketLength;
    } else {
        print "- Operator"
        # some form of operator

        # where are we in the bit stream
        pCurrentPosition=7;
        pLengthTypeId=substr(pPacket,pCurrentPosition,1); pRemainingPacketLength=pRemainingPacketLength-1; pCurrentPosition=pCurrentPosition+1;
        print " -- pLengthTypeId " pLengthTypeId;
        if ( pLengthTypeId=="0" ) {
            # total bits
            pLengthBin=substr(pPacket,pCurrentPosition,15); pRemainingPacketLength=pRemainingPacketLength-15; pCurrentPosition=pCurrentPosition+15;
            pPacket=substr(pPacket,pCurrentPosition);
            # simple, process as packets
            pPacket=process(pPacket);
            pCurrentPosition=1;
            pRemainingPacketLength=length(pPacket);
        } else {
            # sub packet count
            pLengthBin=substr(pPacket,pCurrentPosition,11); pRemainingPacketLength=pRemainingPacketLength-11; pCurrentPosition=pCurrentPosition+11;
        }
        pLengthDec=bin2Dec(pLengthBin);
        print " -- pLengthBin b" pLengthBin " d" pLengthDec;
    }
    pPacket=substr(pPacket,pCurrentPosition+pRemainingPacketLength);
    print "Goodbye " q pPacket q;
    return pPacket;
}

{
    print "input is " $0;
    inp=$0;
    inpBinary="";
    for (i=1;i<length(inp)+1;i++) {
        thisBin=hexNum2Bin[ substr(inp,i,1) ];
        inpBin=inpBin thisBin;
    }
    print " binary " inpBin;
    # sanity checks code
    if (1) {
        if ( inpBin=="110100101111111000101000" ) {
            print " number passed test1 sanity check"
        } else {
            print " number FAILED test1 sanity check"
        }
        if ( inpBin=="00111000000000000110111101000101001010010001001000000000" ) {
            print " number passed test2 sanity check"
        } else {
            print " number FAILED test2 sanity check"
        }
    }

    for (; inpBin!="" ;) {
        # print "xmit> " q inpBin q;
        inpBin=process(inpBin);
        # print "recv> " q inpBin q;
    }
}

END {
    print "DONE!";
}