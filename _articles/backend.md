---
id: backend
title: Backend tools
author: stub
---

Backend tools refer to programs that run on the computer serving a website, as opposed to front-end tools that run within a user's browser.  These include databases that provide searchable access to data, computer algebra systems enabling on-the-fly computations, and templating engines that allow for the dynamic creation of webpages.

# Databases

Using a database provides an alternative to storing your data in text files; they offer much more powerful search functionality and ways of dynamically mixing different parts of the dataset upon demand.  Most relational databases use the SQL language (including [PostgreSQL](/a/postgres), MySQL and SQLite), while NoSQL databases (such as MongoDB and Cassandra) offer flexibility for less structured data.  There are also more exotic options such as object oriented databases and graph databases.

# Computer algebra systems

For mathematical databases, one benefit of running on a personal or cloud server is that you can connect your website to a computer algebra system, allowing for on-the-fly computations to augment stored data.  Be aware that complicated computations are problematic both because of increased latency in serving webpages and because of memory and CPU demands on the server.  If you are using closed source systems such as Magma, Mathematica, Maple or Matlab, make sure that the license allows for your intended use.

# Web application frameworks

Another class of useful backend tools are templating engines, which allow for the dynamic creation of webpages by using stored data to fill in a template.  This allows databases such as the [LMFDB](/d/lmfdb) to include hundreds of millions of pages, without having to save hundreds of millions of html pages to disk.  Templating engines include [Flask and Jinja](/a/flask), Django, FastAPI, and Express/Node.js.

# Static templating engines

While dynamic templating engines construct webpages upon demand, static options such as Jekyll (used by Github Pages), Gatsby and Hugo create html files once, which are then served by a webserver.