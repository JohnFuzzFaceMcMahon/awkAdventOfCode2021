BEGIN {

}

{
    # position array is the list of each sub at a particular position
    positionLength=split($0,position,",");
}

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

function abs(absX1) {
    if (absX1<0) return -1*absX1;
    return absX1;
}

function printRange() {
    for (prIndex=leftLocation;prIndex<rightLocation+1;prIndex++) {
        printf("%s@%s ",location[prIndex],prIndex);
    }
    print "";
}

END {
    # The minimum position of the subs 
    leftLocation=999999999999999999999;
    # The maximum position of the subs
    rightLocation=0;
    # for each sub
    for (i=1;i<positionLength+1;i++) {
        # location array is the number of subs at a particular position
        location[ position[i] ]++;
        # does this move the range to the left?
        leftLocation=min(leftLocation,position[i]);
        # or to the right?
        rightLocation=max(rightLocation,position[i]);
    }
    print "Sub Range Is " leftLocation " To " rightLocation;
    printRange();

    minFuel=999999999999999999999;
    minFuelLocation=999999999999999999999;
    # calculate fuel to move to each position
    # what position are we looking to move to?
    for (locationIndex=leftLocation;locationIndex<rightLocation+1;locationIndex++) {
        fuelConsumption=0;
        # what position are we moving from?
        for (moverIndex=leftLocation;moverIndex<rightLocation+1;moverIndex++) {
            # calculate fuel cost at this position
            # number of subs * absolute distance
            fuelCost=location[moverIndex] * abs( locationIndex - moverIndex );
            fuelConsumption=fuelConsumption+fuelCost;
        }
        print "fuelConsumption for location " locationIndex " is " fuelConsumption;
        # is this result less than the current minimum fuel consumption?
        if ( min(fuelConsumption,minFuel)==fuelConsumption ) {
            minFuel=fuelConsumption;
            minFuelLocation=locationIndex;
        }
    }
    print "Minimum Fuel Consumption Is " minFuel " By Centering On Position " minFuelLocation;
}