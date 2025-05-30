---
id: ci-testing
title: Continuous integration
author: stub
---

If development of your database is ongoing past its initial publication, it is important to set up tests to ensure that changes made to the database do not break something unintentionally.  Continuous integration is a process by which such tests are run in an automated way; if you host your code on [Github](/a/github) then [Github Actions](https://docs.github.com/en/actions/about-github-actions/about-continuous-integration-with-github-actions) provides a mechanism for running such tests in an automated way whenever changes are made.

Errors can arise from either changes to the code used to generate the website or changes to the underlying data.  A common approach is to actually run the code that generates the website and check that the resulting pages satisfy certain constraints (such as containing expected strings).  You can also run a random sample of the [mathematical tests](/a/math-testing) on a regular basis.