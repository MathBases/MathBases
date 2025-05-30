---
id: math-coding
title: Writing code
author: stub
---

While details will of course vary with the specific mathematics, we collect some advice for writing code to compute large datasets.

 * Spend some time finding out what related algorithms and implementations exist before writing your own.  These may be part of large computer algebra systems such as [SageMath](https://sagemath.org), [GAP](https://gap-system.org), [Pari](https://pari.math.u-bordeaux.fr/), [Singular](https://www.singular.uni-kl.de/), [Macaulay2](https://macaulay2.com/), [Magma](https://magma.maths.usyd.edu.au/), [Mathematica](https://www.wolfram.com/mathematica/), [Matlab](https://www.mathworks.com/products/matlab.html), or [Maple](https://www.maplesoft.com/products/maple/), or more specialized software.  You can search for software on [swMath](https://zbmath.org/software/) or Google.

 * As always when programming, document your code.

 * Work iteratively on a smaller scale than you eventually intend to compute.  Ideally, you will work on your [interface](/a/website_coding) in parallel with computing data, since the interface can often make it easier to spot errors and can suggest additional quantities to compute.

 * Output timing and memory usage as part of your computations; this will make it easier to estimate the overall resources required and will be useful if you write a paper about the computation.

 * Ideally, if you find a bug you should aim to fix the bug and rerun the whole computation, ensuring that the problem did not propogate and that your whole process is functional from start to finish.  This aim is part of why it's useful to run computations and tests at smaller scales, to hopefully find bugs early.  This ideal is not always achievable because of time and resource costs, but remember that your coding time is probably the most expensive aspect of the project.