From the beginning
------------------

I managed to get Part 1 finished pretty easily. The code changes for Part 2 were very simple. The problem is that the
data is growing by leaps and bounds! I'm currently running the Part 2 program on the test data. Step 20 (now complete)
took around 3900 seconds (65 minutes). Step 21 took 21742 seconds (6 hours). Now 10% through Step 22 and the program is 
cranking at a whopping??!? 109 pair checks per second. I have a long wait to verify the test, and a longer wait to run
the real data! 

Pushing day14part2.awk to GitHub, but it isn't fully tested obviously...

Stats as of 1PM US/Eastern on 2021-12-14. Day 12 is noticable in its absence.

      --------Part 1---------   --------Part 2--------
Day       Time    Rank  Score       Time   Rank  Score
 14   02:14:28   11827      0          -      -      -
 13       >24h   35728      0       >24h  34908      0
 11       >24h   41018      0       >24h  40809      0
 10       >24h   50024      0       >24h  48745      0
  9       >24h   54768      0       >24h  49154      0
  8       >24h   55654      0       >24h  51553      0
  7       >24h   63445      0       >24h  61823      0
  6       >24h   66742      0       >24h  63556      0
  5   02:07:19   10928      0       >24h  64491      0
  4   04:37:46   16865      0   05:31:58  17147      0
  3   00:44:36   12475      0       >24h  69621      0
  2   00:09:29    6568      0   00:15:46   6785      0
  1   21:27:12  102479      0   23:13:41  93920      0

2021-12-15 1637
---------------

The Part 2 code is, in a word, slow. On my now control-d'd run the stats for Step 22 out of 40
is below. That works out to is 27.5 hours of wall clock time for one pass. Total run was
approaching 35 hours.

There must be a better way to do this.

step 22 at 1639498468
10% 629145 time since last mark 5771s
10% 629145 speed 109.018 pair checks per second 
20% 1258290 time since last mark 7208s
20% 1258290 speed 96.9481 pair checks per second 
30% 1887435 time since last mark 8332s
30% 1887435 speed 88.5662 pair checks per second 
40% 2516580 time since last mark 8141s
40% 2516580 speed 85.4468 pair checks per second 
50% 3145725 time since last mark 8927s
50% 3145725 speed 81.9647 pair checks per second 
60% 3774870 time since last mark 10386s
60% 3774870 speed 77.4094 pair checks per second 
70% 4404015 time since last mark 11061s
70% 4404015 speed 73.6137 pair checks per second 
80% 5033160 time since last mark 12006s
80% 5033160 speed 70.0685 pair checks per second 
90% 5662305 time since last mark 13017s
90% 5662305 speed 66.7339 pair checks per second 
100% 6291450 time since last mark 14310s
100% 6291450 speed 63.4481 pair checks per second 
end step 22 polymer length is 12582913 time for step 99159s

Renaming Part 2 as a warning to others.

More later.
