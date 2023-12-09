---
# Fill in the content below, move into _databases folder
id: my-favorite-database # REQUIRED, SAME AS FILE NAME
location: "https://my-favorite-database.org" # REQUIRED, can be url, issn, etc
title: "My Favorite Dataβase" # REQUIRED, the display name
ascii_name: "My Favorite Database" # REQUIRED IFF title contains a non-standard character
license: "CC BY-SA 4.0" # ENCOURAGED, the license under which the data may be used
num_objects: 123456 # OPTIONAL, number of objects in the dataset
num_datasets: 4 # OPTIONAL, number of collections of different objects; omit if equal to 1
num_contributors: 123 # OPTIONAL, for large collaborative projects where authors aren't listed
size: 87654321 # OPTIONAL, the approximate size in bytes
is_compressed: true # OPTIONAL, whether the size refers to a compressed file
generation_time: 99999 # OPTIONAL, the approximate total time spent in generating the data in seconds on one CPU
code_location: "https://github.org/my-favorite-database-code" # OPTIONAL, location of the code used to generate the data
start_date: 1879 # OPTIONAL, approximate year when the project started
accessible: true # OPTIONAL, data can still be accessed at location above
completeness: >
  We include all foo up to order 42
  and all bar of order up to 5077 # OPTIONAL, a string describing the data's completeness, encouraged if it has the completeness_guarantee badge
searchable: true # OPTIONAL, whether there is a search interface available at the location provided above
short_description: "A database of our favorite mathematical databases" # OPTIONAL, at most one sentence, delimit with quotation marks
contact_email: info@my_favorite_database.org # OPTIONAL, contact email for the database
authors: # OPTIONAL, can omit for large projects (in such case can include a single "author" with a collaboration email/webpage)
  - name: Emmy Noether
    homepage: "https://uni-goettingen.de/~enoether"
  - name: Leonhard Euler
    email: euler@unibas.ch
  - name: Nameless Undergrad
references: # OPTIONAL, include as many as you like
  - url: "https://other_databaase.com"
  - doi: 10.0000/0000
  - arxiv: 9999.54321
  - mr: 123456
  - paper: "Emmy Noether and Leonhard Euler.  The Best Paper.  Annals of Math 1 (1879) no 2. pp 1-16."
  - issn: 12345678
  - other: "Satellite imagery stored on Mars." # Please avoid; only use if none of the above are appropriate
tags: # OPTIONAL, see _data/tags.yml for a list of valid tags
  - arXiv.NT
  - csv
badges: # OPTIONAL, see _data/badges.yml for a list of valid badges
  - collaborative
  - has_license
  - downloadable
  - citable
  - completeness_guarantee
  - cas_connection
  - fm_connection
  - content_documentation
  - schema3 # schema description quality: 3/3
  - has_labels
  - has_code # code that generates the data is available
---

This database contains the best work of Noether and Euler, in one corpus.

Here are some examples of the amazing objects within:

- All finite rings
- All quadratic forms
