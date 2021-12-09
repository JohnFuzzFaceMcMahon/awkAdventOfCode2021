BEGIN {
    print "BEGIN";
    q="\"";
    globalTotal=0;
}

function notARealSort(narsInput) {
    # the proper order
    narsString="abcdefg";
    narsOutput="";
    for (narsI=1;narsI<8;narsI++) {
        # which character are we testing?
        narsTestCharacter=substr(narsString,narsI,1);
        # is it in the input string?
        # if so then put it in the output string 
        if ( index(narsInput,narsTestCharacter)>0 ) {
            narsOutput=narsOutput narsTestCharacter;
        }
    }
    return narsOutput;
}

{
    print  "Raw Input  " $0;
    printf("Sort Input ");
    # what was observed ($1 to $10)
    for (i=1;i<10+1;i++) {
        observation[i]=notARealSort($i);
        printf("%s ",observation[i]);
    }
    printf("| ",observation[i]);
    # what is displayed
    for (i=12;i<15+1;i++) {
        displayAdjust=i-11;
        display[displayAdjust]=notARealSort($i);
        printf("%s ",display[displayAdjust]);
    }
    print "";
    total=0;
    for (i=1;i<4+1;i++) {
        testPattern=display[i];
        lengthPattern=length(testPattern);
        printf("Display pattern %s is %7s Length is %s ",i,testPattern,lengthPattern);
        if (lengthPattern==2) { printf("Value 1 "); total++; }
        if (lengthPattern==3) { printf("Value 7 "); total++; }
        if (lengthPattern==4) { printf("Value 4 "); total++; }
        if (lengthPattern==7) { printf("Value 8 "); total++; }
        print "";
    }
    globalTotal=globalTotal+total;
    print "Subtotal for this line " total " Current total " globalTotal;
    print "-";
}

END {
    print "DONE";
}