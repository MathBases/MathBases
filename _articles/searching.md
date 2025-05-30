---
id: searching
title: Search interface
author: stub
---

The ability to easily search for examples satisfying specified criteria adds greatly to the value of a dataset.  Such interfaces are possible either as part of a computer algebra system or when serving a dataset through a web interface with a database backend.

# Computer algebra systems

Since a user is already writing code as part of accessing the data, the ability to iterate through all objects in the dataset already provides a great deal of value.  For large datasets, providing the ability to iterate over a subset of the dataset picked out by user-specified criteria can help make searches much more efficient.  Enabling this feature is easiest if you store the actual data using database software such as SQLite rather than in plain text files.

# Web interface

The [LMFDB](https://lmfdb.org) and the [House of graphs](https://houseofgraphs.org/search) provide two models for constructing queries dynamically from user entered requirements.  Each allows for multiple constraints to be given, with constraints taking the form of equalities, inequalities, and ranges.  When writing such an interface, be aware of security issues related to [SQL injection](https://en.wikipedia.org/wiki/SQL_injection).

# SQL interface

It is also possible to provide direct SQL access to the database.  This can be valuable for more advanced users who want to run queries that are difficult to construct via a CAS or web interface.