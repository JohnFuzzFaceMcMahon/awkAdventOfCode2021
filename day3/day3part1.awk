BEGIN {

}

{
	bitWidth=length($0);

	for (i=1;i<bitWidth+1;i++) {
		bit[i]=substr($0,i,1);
	}

	printf("%s ",$0);
	for (i=1;i<bitWidth+1;i++) {
		if ( bit[i]==0 ) {
			# It is a zero
			gamma[i "," 0]++;
		} else {
			# It is (hopefully) a one
			gamma[i "," 1]++;
		}
		printf("%d,%d,%d ",i,gamma[i "," 0],gamma[i "," 1]);
	}
	print "";
}

END {
	# Figure out gamma and epsilon 
	gammaRate=0;
	epsilonRate=0;
	gammaRateBinary="";
	epsilonRateBinary="";
	for (i=1;i<bitWidth+1;i++) {
		if ( gamma[i "," 0] > gamma[i "," 1] ) {
			# gamma no increment here
			gammaRateBinary=gammaRateBinary "0";
			# epsilon increment here
			epsilonRateBinary=epsilonRateBinary "1";
			epsilonRate=epsilonRate + 2**(bitWidth-i);
		} else {
			if ( gamma[i "," 0] < gamma[i "," 1] ) {
				# gamma increment here
				gammaRate=gammaRate + 2**(bitWidth-i);
				gammaRateBinary=gammaRateBinary "1";
				# epsilon no increment here
				epsilonRateBinary=epsilonRateBinary "0";
			} else {
				print "UH OH " $0;
				exit;
			}
		} 
	}
	print "Ɣ Rate=" gammaRate " (" gammaRateBinary ")";
	print "Ε Rate=" epsilonRate " (" epsilonRateBinary ")";
	print "Checksum=" gammaRate+epsilonRate " (Should be " (2**bitWidth)-1 ")";
	print "Power Consumption=" gammaRate*epsilonRate;
}
