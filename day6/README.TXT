
2021-12-08 15:00 Started Part 2 with a tweaked version of Part 1. The test data took over three hours to run and dropped with a errno 137 (Out of memory). This is on a 2019 16" Macbook Pro running Mac OS X 10.15.7 (Catalina) stock awk (awk -version returns "awk version 20070501"). 

2021-12-08 20:30 Thought about it over dinner and realized that the brute force method wouldn't work with such large numbers. The new version is amazingly quick. Thankfully awk didn't choke on the huge numbers. 
