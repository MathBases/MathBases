---
id: flask
title: Flask and Jinja
author: stub
---

[Flask](https://flask.palletsprojects.com/en/stable/) is a web application framework written in [Python](https://www.python.org/).  It uses [Jinja](https://jinja.palletsprojects.com/en/stable/) for creating [templates](https://flask.palletsprojects.com/en/stable/tutorial/templates/), which allow for dynamicly creating webpages based on a common pattern.  For example, this technique allows the LMFDB to contain millions of pages, with each being created from dozens of templates by filling in data from an underlying [PostgreSQL database](/a/postgres).