BEGIN {

}

function showGridAndFlash( i,j) {
    # row (Y)
    print "       1   2   3   4   5   6   7   8   9   0"
    print "   +-----------------------------------------+"
    for (i=1;i<10+1;i++) {
        # column (X)
        printf("%2.2d | ",i);
        for (j=1;j<10+1;j++) {
            printf("%X/%X ", grid[j "|" i], flash[j "|" i]);
        }
        print "|";
    }
    print "   +-----------------------------------------+"
}

{
    inp=$0;
    #print "Line " NR;
    for (i=1;i<10+1;i++) {
        # energy level of octopus
        grid [i "|" NR]=int(substr(inp,i,1));
        # did they flash this step
        flash[i "|" NR]=0;
    }
}

END {
    print "Initial Status"
    showGridAndFlash();
    print "";

    totalFlashCount=0;

    # step process
    # increase the energy of each octopus by one
    for (step=1;step<1000+1;step++) {
        for ( octopus in grid ) {
            print "Increasing Octopus " octopus " in step " step;
            grid[octopus]++;
        }
        # flashing loop
        stopFlash=0;
        # clear the flash array
        for ( octopus in flash ) {
            print "flashing array " octopus " cleared in step " step;
            flash[octopus]=0;
        }
        for (; stopFlash==0 ;) {
            # assume we are stopping
            stopFlash=1;
            # look for a flasher
            # row (Y)
            for (i=1;i<10+1;i++) {
                # column (X)
                for (j=1;j<10+1;j++) {
                    # does a flash occur?
                    print "checking for flash at " j "," i " in step " step " energy level " grid[j "|" i] " did flash " flash[j "|" i] " stop flash " stopFlash;
                    if ( (grid[j "|" i] > 9) && (flash[j "|" i]==0) ) {
                        print "Octopus " j "," i " is flashing";
                        totalFlashCount++;
                        stopFlash=0;
                        # set the flash array
                        flash[j "|" i]=1;
                        # bump up the energy of those around
                        # NW - N - NE
                        grid[j-1 "|" i-1]++;
                        grid[j   "|" i-1]++;
                        grid[j+1 "|" i-1]++;
                        # E - W
                        grid[j-1 "|" i]++;
                        grid[j+1 "|" i]++;
                        # SW - S - SE 
                        grid[j-1 "|" i+1]++;
                        grid[j   "|" i+1]++;
                        grid[j+1 "|" i+1]++; 
                    }
                    print "end flash check";
                }
                print "end column loop";
            }
            print "end row loop ";
        }
        print "end flash loop";
        # OK, we are done with flashing...
        # Zero out anyone who flashed this time...
        # row (Y)
        stepFlashCount=0;
        for (i=1;i<10+1;i++) {
            # column (X)
            for (j=1;j<10+1;j++) {
                if (flash[j "|" i]==1) {
                    grid[j "|" i]=0;
                    stepFlashCount++;
                }
            }
        }
        print "After Step " step;
        showGridAndFlash();
        print "totalFlashCount=" totalFlashCount;
        if ((stepFlashCount==100) && (firstAllFlash==0)) {
            firstAllFlash=step;
            print "firstAllFlash is " firstAllFlash;
            exit;
        }
        print "";
    }
}