---
id: postgres
title: PostgreSQL
author: stub
---

[PostgreSQL](https://www.postgresql.org/) is an open source object-relational database.  It needs a server to host the database (you can't just run it in [Github pages](/a/github)), but offers powerful search features and excellent performance.

To set up a new database, see the [tutorial](https://www.postgresql.org/docs/current/tutorial-start.html).  You can connect to the database using many [different clients](https://wiki.postgresql.org/wiki/PostgreSQL_Clients); which one you choose to use will depend on your stack of [backend](/a/backend) and [frontend](/a/frontend) software.

* If you are using Python on the backend, you can consider [psycopg3](https://www.psycopg.org/psycopg3/) or [psycodict](https://github.com/roed314/psycodict).
* For plain Ruby, you can use [ruby-pg](https://github.com/ged/ruby-pg).  If you are using Ruby on rails, it comes with built-in [postgres adapters](https://guides.rubyonrails.org/configuring.html#configuring-a-database)
* There are also many ways to connect to postgres from Javascript, including [Postgres.js](https://github.com/porsager/postgres), [node-postgres](https://node-postgres.com/).