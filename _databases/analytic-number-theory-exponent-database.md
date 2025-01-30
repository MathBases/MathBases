---
# Fill in the content below, move into _databases folder
id: analytic-number-theory-exponent-database
location: "https://github.com/teorth/expdb"
title: "Analytic Number Theory Exponent Database (ANTEDB)"
# ascii_name: "My Favorite Database" # REQUIRED IFF title contains a non-standard character
license: "Apache 2.0"
#num_objects: 123456 # OPTIONAL, number of objects in the dataset
#num_datasets: 4 # OPTIONAL, number of collections of different objects; omit if equal to 1
#num_contributors: 123 # OPTIONAL, for large collaborative projects where authors aren't listed
#size: 87654321 # OPTIONAL, the approximate size in bytes
#is_compressed: true # OPTIONAL, whether the size refers to a compressed file
#generation_time: 99999 # OPTIONAL, the approximate total time spent in generating the data in seconds on one CPU
#code_location: "https://github.org/my-favorite-database-code" # OPTIONAL, location of the code used to generate the data
start_date: 2024
accessible: true # OPTIONAL, data can still be accessed at location above
#completeness: >
#  We include all foo up to order 42
#  and all bar of order up to 5077 # OPTIONAL, a string describing the data's completeness, encouraged if it has the completeness_guarantee badge
# searchable: true # OPTIONAL, whether there is a search interface available at the location provided above
short_description: "A living database of the known bounds and relations between exponents of interest in analytic number theory"
# contact_email: info@my_favorite_database.org # OPTIONAL, contact email for the database
authors: # OPTIONAL, can omit for large projects (in such case can include a single "author" with a collaboration email/webpage)
  - name: Terence Tao
    homepage: "https://www.math.ucla.edu/~tao/"
  - name: Timothy Trudgian
    homepage: "https://research.unsw.edu.au/people/professor-timothy-trudgian"
  - name: Andrew Yang
    homepage: "https://www.unsw.edu.au/hdr/andrew-yang"
references: # OPTIONAL, include as many as you like
  - arxiv: 2501.16779
  - blog: https://terrytao.wordpress.com/2025/01/28/new-exponent-pairs-zero-density-estimates-and-zero-additive-energy-estimates-a-systematic-approach/
tags: # OPTIONAL, see _data/tags.yml for a list of valid tags
  - arXiv.NT
badges: # OPTIONAL, see _data/badges.yml for a list of valid badges
  - collaborative
  - has_license
  - downloadable
---

An ongoing project to systematically record known theorems for various exponents appearing in analytic number theory, as well as the relationships between them. 

 Currently, the database is recording facts and conjectures on exponent pairs, exponential sum bounds, zero-density and moment bounds for the Riemann zeta-function, large value estimates, additive energy bounds and exponents related to prime distributions, amongst other results.