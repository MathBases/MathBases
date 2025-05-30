---
id: computation-at-scale
title: Computation at scale
author: stub
---

Once you have finished [writing](/a/math-coding) and [testing](/a/math-testing) the code for computing your data, you need to decide how extensively you want to run it.  While some mathematical datasets are finite, most involve enumerating a slice of an infinite set based on a choice of parameters.  Choosing limits on those parameters is an optimization problem, aiming to derive the most scientific payoff from the least resource expenditure.

1. Computational resources are fairly inexpensive (a CPU-year on Google compute engine costs as little as $25); make sure that you're appropriately balancing your time spent programming and optimizing with the resources spent on computation.

2. Using cloud servers can allow you to finish a computation very quickly, paying only for what you use.  The top providers are [Amazon Web Services](https://aws.amazon.com/ec2/spot/), [Microsoft Azure](https://azure.microsoft.com/en-us/products/virtual-machines/spot) and [Google Cloud Platform](https://cloud.google.com/spot-vms/pricing).  Preemptible spot instances can save you a lot of money (you get a large discount for allowing them to stop your jobs when they need servers for something else)

3. Parallelize as much as possible.  [GNU parallel](https://www.gnu.org/software/parallel/parallel_tutorial.html) makes parallelizing easy as long as your program can be run from a unix command line.

4. It can be valuable to structure your code so that you can get partial results if you run into cases where certain aspects of the computation time out or run into errors in the computer algebra system you are using.