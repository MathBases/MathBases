---
# Fill in the content below, move into _databases folder
id: tangles # REQUIRED, SAME AS FILE NAME
location: "https://tangleinfo.cent.uw.edu.pl/" # REQUIRED, can be url, issn, etc
title: "TangleInfo" # REQUIRED, the display name
# ascii_name: "My Favorite Database" # REQUIRED IFF title contains a non-standard character
license: "CC BY-SA 4.0" # ENCOURAGED, the license under which the data may be used
# num_objects: 123456 # OPTIONAL, number of objects in the dataset
# num_datasets: 4 # OPTIONAL, number of collections of different objects; omit if equal to 1
# num_contributors: 123 # OPTIONAL, for large collaborative projects where authors aren't listed
# size: 87654321 # OPTIONAL, the approximate size in bytes
# is_compressed: true # OPTIONAL, whether the size refers to a compressed file
# generation_time: 99999 # OPTIONAL, the approximate total time spent in generating the data in seconds on one CPU
# code_location: "https://github.org/my-favorite-database-code" # OPTIONAL, location of the code used to generate the data
# start_date: 1879 # OPTIONAL, approximate year when the project started
accessible: true # OPTIONAL, data can still be accessed at location above
#completeness: >
#  We include all foo up to order 42
# and all bar of order up to 5077 # OPTIONAL, a string describing the data's completeness, encouraged if it has the completeness_guarantee badge
searchable: true # OPTIONAL, whether there is a search interface available at the location provided above
short_description: "Database of algebraic tangles" # OPTIONAL, at most one sentence, delimit with quotation marks
# contact_email: info@my_favorite_database.org # OPTIONAL, contact email for the database
authors: # OPTIONAL, can omit for large projects (in such case can include a single "author" with a collaboration email/webpage)
  - name: Bartosz A. Gren 
    email: b.gren@cent.uw.edu.pl
  - name: Joanna I. Sulkowska
    email: j.sulkowska@cent.uw.edu.p
  - name: Boštjan Gabrovšek 
references: # OPTIONAL, include as many as you like
  - arxiv: 2504.06901
tags: # OPTIONAL, see _data/tags.yml for a list of valid tags
  - tangles
  - knot theory
  - mutant knots
  - symmetry groups
badges: # OPTIONAL, see _data/badges.yml for a list of valid badges
---

This database contains algebraic tangles and their symmetry groups with up to 14 crossings. 
