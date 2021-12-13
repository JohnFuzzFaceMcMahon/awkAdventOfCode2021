BEGIN {

}

{
    inputArray[NR]=$0;
}

END {
    syntaxErrorCount=0;
    incompleteCount=0;
    failValueTotal=0;
    for (i=1;i<NR+1;i++) {
        inputLength=length(inputArray[i]);
        testOpen  ="([{<";
        testClosed=")]}>";
        firstFailure=0;
        failValue[1]=3;
        failValue[2]=57;
        failValue[3]=1197;
        failValue[4]=25137;

        layer=0;
        layerArray[layer]=0;
        layerArrayString[layer]="ZERO";
        syntaxError=0;
        print i,inputArray[i];
        for (j=1;j<inputLength+1;j++) {
            # the current characer in the string
            currentCharacter=substr(inputArray[i],j,1);
            # look for open and closed
            ttQ=index(testOpen,currentCharacter);
            ttC=index(testClosed,currentCharacter);
            # print currentCharacter, layer, layerArray[layer], layerArrayString[layer], ttQ, ttC;
            if ( ttQ>0 ) {
                layer++;
                layerArray[layer]=ttQ;
                layerArrayString[layer]=currentCharacter;
            }
            if ( ttC>0 ) {
                if ( ttC==layerArray[layer] ) {
                    # no problem!
                    layer--;
                } else {
                    syntaxError=1;
                    print "invalid at " j " found " currentCharacter " expecting close for " layerArrayString[layer];
                    if (firstFailure==0) {
                        firstFailure=1;
                        failValueTotal=failValueTotal+failValue[ttC];
                        print "failValue " failValue[ttC] " failValueTotal " failValueTotal;
                    } 
                }
            }
        }
        if ( syntaxError==1 ) { syntaxErrorCount++; print "syntax error"; } else { print "syntax ok"; }
        if ( (layer!=0) && (syntaxError!=1) ) {
            incompleteCount++;
            print "incomplete";
            compString="";
            for (z=layer;z>0;z--) {
                ccc1=layerArrayString[z];
                ccc2=index(testOpen,ccc1);
                ccc3=substr(testClosed,ccc2,1)
                compString=compString ccc3;
            }
            print "needed to complete " compString;
            testFix=")]}>";
            totalScore=0;
            for (zz=1;zz<length(compString)+1;zz++) {
                zzCharacter=substr(compString,zz,1);
                zzValue=index(testClosed,zzCharacter);
                totalScore=totalScore*5+zzValue;
            }
            print "total score for this line is " totalScore;
            tsac++;
            tsa[tsac]=totalScore;
        } 
        print "";      
    }
    print "total lines " NR " fail value " failValueTotal " complete " NR-incompleteCount " syntax OK " NR-syntaxErrorCount;

    # cut and paste from day 9 part 2    
    eeDidSort=1;
    for (; eeDidSort==1 ;) {
        eeDidSort=0;
        for(eeI=1;eeI<tsac;eeI++) {
            print eeI " | " tsac " | " tsa[eeI] " | " tsa[eeI+1];
            if ( tsa[eeI]<tsa[eeI+1]) {
                eeDidSort=1;
                eeTemp=tsa[eeI];
                tsa[eeI]=tsa[eeI+1];
                tsa[eeI+1]=eeTemp;
                print "swap";
            }
        }
    }
    for (gggI=1;gggI<tsac+1;gggI++) {
        print gggI,tsa[gggI];
    }

    print "ANSWER " tsa[ (tsac+1)/2 ];
}