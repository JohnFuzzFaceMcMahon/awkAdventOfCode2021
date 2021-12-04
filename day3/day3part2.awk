BEGIN {
    print "### BEGIN - HELLO";
}

{
    # Length Of Input Data
    inputLength=length($0);
    # a Is The Master Array
    a[NR]=$0;
    print "### MAIN - INGEST AT ARRAY INDEX " NR " ARRAY VALUE " $0;
}

function arrayBitCount(abcX) {

    # look in the array at bit position abcX, count 1s and 0s, return the values

    # how many 0
    abcY0=0;
    # how many 1
    abcY1=0;
    # start looking
    # abcZ is the array index
    for (abcZ=1;abcZ<NR+1;abcZ++) {
        # check to see if the value has been nuked
        abcB=og[abcZ];
        if ( abcB!="" ) {
            # abcA is the value of the bit
            abcA=substr( og[abcZ], abcX, 1);
            if (abcA=="1") { abcY1++; } else { abcY0++; }
        } else {
            abcA="*NUKED*";
            abcB="*NUKED*"
        }
        print "### arrayBitCount - BIT POSITION " abcX " ARRAY INDEX " abcZ " ARRAY VALUE " abcB " THIS BIT VALUE " abcA " ONE COUNT " abcY1 " ZERO COUNT " abcY0;
    }
    print "### arrayBitCount - RETURNING " abcY0 "," abcY1;
    return abcY0 "," abcY1;

}

function arrayReduction(arX,arY) {

    # look for arY (bit value) at position arX, nuke if no match

    # arZ is the array index
    for (arZ=1;arZ<NR+1;arZ++) {
        # copy the array value into arA
        arA=og[arZ];
        # check for not nuked
        if (arA!="") {
            # arB is the value of the bit 
            arB=substr( arA, arX, 1);
            print "### arrayReduction - ITEM " arA " BIT POSITION " arX " ARRAY INDEX " arZ " ARRAY VALUE " arA " BIT AT POSITION " arB " LOOKING FOR " arY;
            if (arB==arY) {
                print "### arrayReduction - SAVE"
            } else {
                print "### arrayReduction - NUKE";
                og[arZ]="";
            }
        } else {
           print "### arrayReduction - ITEM *NUKED* BIT POSITION " arX " ARRAY INDEX " arZ " ARRAY VALUE *NUKED* BIT AT POSITION *NUKED* LOOKING FOR " arY; 
        }
    }
    # How Many Left?
    arC=0;
    # Last One Seen?
    arD="*ZILCH*";
    # arZ is the array index
    for (arZ=1;arZ<NR+1;arZ++) {
        # copy the array value into arA
        arA=og[arZ];
        if (arA!="") {
            arC++;
            arD=arA;
            print "### arrayReduction - COUNTING ARRAY INDEX " arZ " ARRAY VALUE " arA " HOW MANY " arC " LAST SEEN " arD;
        } else {
            print "### arrayReduction - SKIPPING ARRAY INDEX " arZ " ARRAY VALUE *NUKED* HOW MANY " arC " LAST SEEN " arD;
        }
    }
    print "### arrayReduction - RETURNING " arC "," arD;
    return arC "," arD;
}

function binaryStringToValue(bstvX) {

    # Convert a binary string to an integer binaryStringToValue

    # bstvX is the input value
    # length of string is bstvY
    bstvY=length(bstvX);

    # bstvA is the calculated total
    bstvA=0;
    # bstvZ is the index for the digit we are working on
    for(bstvZ=1;bstvZ<bstvY+1;bstvZ++) {
        if ( substr(bstvX,bstvZ,1)=="1" ) {
            bstvA=bstvA+2**(bstvY-bstvZ);
        }
    }
    return bstvA;
}

END {

    # Copy original array into the og array which should have been called "work" or somesuch
    for (ind=1;ind<NR+1;ind++) { 
        og[ind]=a[ind];
    }

    # Calculate OG first

    # Stop the loop early if needed
    stopStopStop=0;
    # which bit position we are working on is in "bit"
    for (bit=1;bit<inputLength+1;bit++) {
        if (stopStopStop==1) {
            print "### END - OG SKIPPING BIT " bit;
            continue;
        }
        print "### END - OG TOP OF LOOP - LOOKING AT BIT POSITION " bit;
        rc=arrayBitCount(bit);
        split(rc,rca,",");
        # rca[1] = number of zeros
        # rca[2] = number of ones

        # What are we looking for?      
        lookingFor="";
        if ( rca[1]>rca[2] ) {
            # looking for zero
            lookingFor="0";
        } else {
            # looking for one
            # this also fires if they are equal, which for OG is fine
            lookingFor="1";
        }
        print "### END - OG LOOKING FOR BIT VALUE " lookingFor;

        rc=arrayReduction(bit,lookingFor);
        split(rc,rca,",");
        # rca[0] = number left
        # rca[1] = last seen
        howMany=rca[1];
        lastSeen=rca[2];
        print "### END - OG RC " rc " HOW MANY " howMany " WHAT VALUE " lastSeen;

        # time for the brakes?
        if (howMany<2) {
            stopStopStop=1;
        }

    }
    OGFINALSTRING=lastSeen;
    OGFINALVALUE=binaryStringToValue(OGFINALSTRING);
    print "### END - OG FINAL HOW MANY " howMany " WHAT VALUE " lastSeen;

    # Copy original array into the og array which should have been called "work" or somesuch
    for (ind=1;ind<NR+1;ind++) { 
        og[ind]=a[ind];
    }

    # Calculate CO2 second

    # Stop the loop early if needed
    stopStopStop=0;
    # which bit position we are working on is in "bit"
    for (bit=1;bit<inputLength+1;bit++) {
        if (stopStopStop==1) {
            print "### END - CO2 SKIPPING BIT " bit;
            continue;
        }
        print "### END - CO2 TOP OF LOOP - LOOKING AT BIT POSITION " bit;
        rc=arrayBitCount(bit);
        split(rc,rca,",");
        # rca[1] = number of zeros
        # rca[2] = number of ones

        # What are we looking for?      
        lookingFor="";

        if ( rca[1]>rca[2] ) {
            # more zeros than ones
            # opposite day looking for one
            lookingFor="1";
        } else {
            # more ones than zeros
            # opposite day looking for zero
            # this also fires if they are equal, which for CO2 is fine
            lookingFor="0";
        }
        print "### END - CO2 LOOKING FOR BIT VALUE " lookingFor;

        rc=arrayReduction(bit,lookingFor);
        split(rc,rca,",");
        # rca[0] = number left
        # rca[1] = last seen
        howMany=rca[1];
        lastSeen=rca[2];
        print "### END - CO2 RC " rc " HOW MANY " howMany " WHAT VALUE " lastSeen;

        # time for the brakes?
        if (howMany<2) {
            stopStopStop=1;
        }

    }
    CO2FINALSTRING=lastSeen;
    CO2FINALVALUE=binaryStringToValue(CO2FINALSTRING);
    print "### END - CO2 FINAL HOW MANY " howMany " WHAT VALUE " lastSeen;

    print "### END - FINAL OG " OGFINALSTRING " " OGFINALVALUE " CO2 " CO2FINALSTRING " " CO2FINALVALUE " LIFE SUPPORT RATING " OGFINALVALUE*CO2FINALVALUE;
}