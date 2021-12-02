BEGIN {
	# horizontal
	hp=0;
	# depth
	dp=0;
	# check
	ok=0;
}

/forward/ {
	hp=hp+$2; ok=1;
}

/down/ {
	dp=dp+$2; ok=1;
} 

/up/ {
	dp=dp-$2; ok=1;
} 
 
{
	if (!ok) { 
		print "FAIL " $0;
		exit;
	}
	ok=0;
	print "horiz=" hp " depth=" dp " mult="i hp*dp;
} 
