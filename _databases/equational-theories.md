---
# Fill in the content below, move into _databases folder
id: equational-theories # REQUIRED, SAME AS FILE NAME
location: "https://teorth.github.io/equational_theories/" # REQUIRED, can be url, issn, etc
title: "Equational theories database" # REQUIRED, the display name
license: "Apache 2.0" # ENCOURAGED, the license under which the data may be used
num_objects: 4694 # OPTIONAL, number of objects in the dataset
code_location: "https://github.com/teorth/equational_theories" # OPTIONAL, location of the code used to generate the data
start_date: 2024 # OPTIONAL, approximate year when the project started
accessible: true # OPTIONAL, data can still be accessed at location above
completeness: >
  We completely classify the relations between 4694 equational laws for magmas.
searchable: true # OPTIONAL, whether there is a search interface available at the location provided above
short_description: "Implications between all equational laws for magmas involving at most four operations" # OPTIONAL, at most one sentence, delimit with quotation marks
contact_email: tao@math.ucla.edu # OPTIONAL, contact email for the database
authors: # OPTIONAL, can omit for large projects (in such case can include a single "author" with a collaboration email/webpage)
  - name: Terence Tao
    homepage: "https://www.math.ucla.edu/~tao/"
  - name: Pietro Monticone
    homepage: "https://github.com/pitmonticone"
  - name: Shreyas Srinivas
    homepage: "https://github.com/Shreyas4991"
area:
  - group theory
badges:
  - collaborative
  - has_license
  - downloadable
  - completeness_guarantee
  - schema3 # schema description quality: 3/3
  - has_code # code that generates the data is available
---

This database contains the complete set of implications between the 4694 equational laws for magmas involving at most four operations.  These implications are formally verified in the proof assistant language Lean.
