BEGIN {
    print "### BEGIN{}";
    q="\"";
}

function notARealSort(narsInput) {

    # take a random string of segments like "acedgfb" and sort them in a predictable order

    # the proper order as a string
    narsString="abcdefg";
    # what we send back in the return
    narsOutput="";
    # in order of narsString
    for (narsI=1;narsI<8;narsI++) {
        # which character are we testing?
        narsTestCharacter=substr(narsString,narsI,1);
        # is it in the input string?
        # if so then put it in the output string 
        if ( index(narsInput,narsTestCharacter)>0 ) {
            narsOutput=narsOutput narsTestCharacter;
        }
    }
    # send it back
    return narsOutput;
}

function burp(burpA, burpB, burpC, burpD, burpE) {
    # A - What number are we testing for
    # B - What number did we just subtract
    # C - Original Length To Test For
    # D - Current Length To Test For
    # E - Index for originalLength and a bunch of other stuff
    if ( originalLength[burpE]==burpC) {
        if ( testStringLength[burpE]==burpD) {
            if ( id[burpE]==0 ) {
                printf("-%s- Observation pattern %s is %7s Original Length is %s Test Length is %s",burpB,burpE,q observation[burpE] q,originalLength[burpE],testStringLength[burpE]);
                printf(" FOUND NUMBER " burpA ); id[burpE]=1; digit[burpA]=observation[burpE]; reverse[ observation[burpE] ]=burpA;
            print "";
            } else {
                print "-" burpB "- Skipping, already identified."
            }
        } else {
            print "-" burpB "- Skipping due to testString mismatch."
        }
    } else {
        print "-" burpB "- Skipping due to originalLength mismatch."
    }
}

{
    # what we got
    print  "Raw Input  " $0;
    # load and sort the elements
    printf("Sort Input ");
    # what was observed ($1 to $10)
    for (i=1;i<10+1;i++) {
        # observation array (1-10)
        observation[i]=notARealSort($i);
        # variables to help when we identify the number
        # id[] - found it (true/false)
        # idX[] - the segments
        id[i]=0; idX[i]=observation[i];
        # original length will help us ID unknown combinations
        originalLength[i]=length(observation[i]);
        printf("%s ",observation[i]);
    }
    printf("| ",observation[i]);
    # what is displayed in the sub (In $0 as $12 through $15, we put it in the array 1-4)
    for (i=12;i<15+1;i++) {
        displayAdjust=i-11;
        display[displayAdjust]=notARealSort($i);
        printf("%s ",display[displayAdjust]);
    }
    ##############################
    print "";
    # look for the easy numbers based on the original length
    print "### Determine Easy Numbers";
    for (i=1;i<10+1;i++) {
        thisPattern=observation[i];
        lengthThisPattern=originalLength[i];
        printf("Observation pattern index %2s is %7s Length is %s ",i,thisPattern,lengthThisPattern);
        if (lengthThisPattern==2) { printf("NUMBER IS 1 "); id[i]=1; idX[i]=thisPattern; digit[1]=thisPattern; reverse[thisPattern]=1; }
        if (lengthThisPattern==3) { printf("NUMBER IS 7 "); id[i]=1; idX[i]=thisPattern; digit[7]=thisPattern; reverse[thisPattern]=7; }
        if (lengthThisPattern==4) { printf("NUMBER IS 4 "); id[i]=1; idX[i]=thisPattern; digit[4]=thisPattern; reverse[thisPattern]=4; }
        if (lengthThisPattern==7) { printf("NUMBER IS 8 "); id[i]=1; idX[i]=thisPattern; digit[8]=thisPattern; reverse[thisPattern]=8; }
        print "";
    }
    # figure out the rest of the numbers
    # start by subtracting the segments for the number 1
    print "### Deduction"
    for (i=1;i<10+1;i++) {
        print "Loop " i;
        # stash a copy of the segments
        testString[i]=observation[i];
 
        # start by subtracting 1
        print "-1- Subtracting 1 "q digit[1] q;
        for (j=1;j<2+1;j++) {
            # get a segment from "1" and then remove it from the testString
            removeThis=substr( digit[1],j,1);
            sub(removeThis,"",testString[i]);
        }
        testStringLength[i]=length(testString[i]);
        printf("-1- Index %s Found %s Original String %7s Length %s Test String %7s Length %s\n",i,id[i],q observation[i] q,originalLength[i],q testString[i] q,testStringLength[i]);
        # Test for 3
        # 3 has an original length of "5" and will have "3" segments remaining after subtraction
        burp(3,1,5,3,i);
        # Test for 6
        # 6 has an original length of "6" and will have "5" segments remaining after subtraction
        burp(6,1,6,5,i);
 
        # now subtract 4
        print "-4- Subtracting 4 "q digit[4] q;   
        for (j=1;j<4+1;j++) {
            # get a segment from "4" and then remove it from the testString
            removeThis=substr( digit[4],j,1);
            sub(removeThis,"",testString[i]);
        }    
        testStringLength[i]=length(testString[i]);
        printf("-4- Index %s Found %s Original String %7s Length %s Test String %7s Length %s\n",i,id[i],q observation[i] q,originalLength[i],q testString[i] q,testStringLength[i]);
        # Test for 0
        # 0 has an original length of "6" and will have "3" segments remaining after both subtractions
        burp(0,4,6,3,i);
        # Test for 2
        # 2 has an original length of "5" and will have "3" segments remaining after both subtractions
        burp(2,4,5,3,i);
        # Test for 5
        # 5 has an original length of "5" and will have "2" segments remaining after both subtractions
        burp(5,4,5,2,i);
        # Test for 9
        # 9 has an original length of "6" and will have "2" segments remaining after both subtractions
        burp(9,4,6,2,i);

        # for (k=0;k<9+1;k++) {
        #    print "?????",k,digit[k];
        # }

    }

    # globalTotal=globalTotal+total;
    # print "Subtotal for this line " total " Current total " globalTotal;
    # print "-";

    print "What Means What?"
    for (i=0;i<9+1;i++) {
        print "The number " i " is pattern " digit[i];
    }

    # Determination
    displayValue=0;
    printf("ANSWER FOR THIS LINE: /");
    for (i=1;i<4+1;i++) {
        printf("%s/",display[i])
    }
    printf(" -> ");
     for (i=1;i<4+1;i++) {
        printf("%s",reverse[ display[i]] );
        displayValue=displayValue + int(reverse[ display[i]])*(10**(4-i));
    }
    globalTotal=globalTotal+displayValue;
    printf(" GRAND TOTAL: %s", globalTotal );
    print "";

}

END {
    print "END {}";
}