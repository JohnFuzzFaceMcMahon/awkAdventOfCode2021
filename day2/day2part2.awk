BEGIN {
	# horizontal
	hp=0;
	# depth
	dp=0;
	# check
	ok=0;
	# aim
	ai=0;
}

/forward/ {
	hp=hp+$2;
	dp=dp+(ai*$2);
	ok=1;
}

/down/ {
	# dp=dp+$2;
	ok=1;
	ai=ai+$2;
} 

/up/ {
	# dp=dp-$2;
	ok=1;
	ai=ai-$2;
} 
 
{
	if (!ok) { 
		print "FAIL " $0;
		exit;
	}
	ok=0;
	print "horiz=" hp " depth=" dp " aim=" ai " mult=" hp*dp;
} 
