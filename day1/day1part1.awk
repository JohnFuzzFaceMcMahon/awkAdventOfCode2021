BEGIN {
	last=-1;
	count=0;
}

{
	current=$1;
	if (last==-1) {
		last=current;
		print "STARTING " last " TO " current " - COUNT IS " count;
	} else {
		caseStatement=0;
		if ((current>last) && (caseStatement==0)) {
			count++;
			print "RISING " last " TO " current " - COUNT IS " count;
			last=current;
			caseStatement=1;
		}
		if ((current==last) && (caseStatement==0)) {
			print "LEVEL " last " TO " current " - COUNT IS " count;
			last=current;
			caseStatement=1;
		}
		if ((current<last) && (caseStatement==0)) {
			print "DIVING " last " TO " current " - COUNT IS " count;
			last=current;
			caseStatement=1;
		}
	}
}

END {
	print "ANSWER " count;
}
