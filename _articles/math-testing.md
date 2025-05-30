---
id: math-testing
title: Data tests
author: stub
---

Users of mathematical datasets have an expectation of correctness that differs from most other kinds of databases.  Unfortunately, software has bugs.  As you [write code](/a/math-coding) to create the data, you should also design and run tests to ensure its reliability.  Several kinds of tests are possible, and all are useful.

1. Testing individual functions in your code, along the lines of Python's [doctest module](https://docs.python.org/3/library/doctest.html).

2. Finding internal consistency checks on the data.  Theorems that imply certain relationships between different pieces of data are particularly useful.

3. Finding external consistency checks on the data.  For example, a theorem that gives the number of objects with a certain property can be used to check that your code is functioning correctly.

4. Using multiple computer algebra systems to compute parts of your data.  Computing data at scale can often uncover bugs in computer algebra systems, and using multiple independent systems can offer more confidence in the correctness of the implementations.

You should make sure to run tests progressively, since finding bugs early before you've spend a lot of time on computations is very valuable, and running tests on the final results ensures that nothing went wrong in an unusual corner case.

It's worth describing the tests that were run to your users as a way to give them confidence in the data.  This is also a good place to reveal any unproven conjectures, randomized algorithms or floating-point methods that were used in the computation.  Certificates and formal proofs are wonderful to offer when possible.

Finally, when your data includes floating point values it is worth being explicit about their precision, since going back and figuring this out afterward can be painful.