# Backwards Gauss-Seidel
Linear equation system solver for a tridiagonal complex matrix using the Backwards Gauss-Seidel
algorithm.

This script has been created for a college project in Numerical Methods II
(Computer Science at [Warsaw University of Technology](http://www.mini.pw.edu.pl/tikiwiki/)).

All the comments, some variable names are in Polish due to the requirements
of the task. I am sorry for all non-Polish speakers.
If you have any questions
feel free to create an issue or contact me directly.


# Usage
This repository contains 3 files:
* _stopCondition.m_ - checks if the stop condition has been met (based on Gill's condition)
* _bgsIteration.m_ - does a single iteration of approximating the solution
* _bgs.m_ - approximates the initial solution by executing `bgsIteration` until `stopCondition`
has been met

# Author
The author of this script is [Grzegorz Rozdzialik](voreny.gelio@gmail.com). 
