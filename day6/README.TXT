
2021-12-08 15:00 Started Part 2 with a tweaked version of Part 1. The test data took over three hours to run and dropped with a errno 137 (Out of memory). This is on a 2019 16" Macbook Pro running Mac OS X 10.15.7 (Catalina) stock awk (awk -version returns "awk version 20070501"). 

2021-12-08 20:30 Thought about it over dinner and realized that the brute force method wouldn't work with such large numbers. The new version is amazingly quick. Thankfully awk didn't choke on the huge numbers or resort to scientific notation. 

My Stats
========

      --------Part 1---------   --------Part 2--------
Day       Time    Rank  Score       Time   Rank  Score
  6       >24h   66742      0       >24h  63556      0
  5   02:07:19   10928      0       >24h  64491      0
  4   04:37:46   16865      0   05:31:58  17147      0
  3   00:44:36   12475      0       >24h  69621      0
  2   00:09:29    6568      0   00:15:46   6785      0
  1   21:27:12  102479      0   23:13:41  93920      0
