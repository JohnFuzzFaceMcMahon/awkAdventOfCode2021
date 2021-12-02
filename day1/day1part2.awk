BEGIN { ind=0; }

{
	array[ind++]=$1;
	count=0;
}

END {
	for (i=0;i<ind;i++) {
		# current
		c=array[i]+array[i+1]+array[i+2];
		# next
		n=array[i+1]+array[i+2]+array[i+3];

                caseStatement=0;
                if ((n>c) && (caseStatement==0)) {
                        count++;
                        print "RISING " c " TO " n " - COUNT IS " count;
                        caseStatement=1;
                }
                if ((n==c) && (caseStatement==0)) {
                        print "LEVEL " c " TO " n " - COUNT IS " count;
                        caseStatement=1;
                }
                if ((current<last) && (caseStatement==0)) {
                        print "DIVING " c " TO " n " - COUNT IS " count;
                        caseStatement=1;
                }
	}
	print "DONE";
}


