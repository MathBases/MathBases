---
# Fill in the content below, move into _databases folder
id: game-of-sloanes # REQUIRED, SAME AS FILE NAME
location: "https://github.com/gnikylime/GameofSloanes" # REQUIRED, can be url, issn, etc
title: "Game of Sloanes" # REQUIRED, the display name
ascii_name: "Game of Sloanes" # REQUIRED IFF title contains a non-standard character
area: # REQUIRED, see _data/areas.yml for a list of valid areas
  - algebraic geometry
  - number theory
license: "CC BY-SA 4.0" # ENCOURAGED, the license under which the data may be used
num_objects: 369 # OPTIONAL, number of objects in the dataset
#num_datasets: 4 # OPTIONAL, number of collections of different objects; omit if equal to 1
#parent_dataset: lmfdb # OPTIONAL, the id of another dataset of which this is a part
#num_contributors: 123 # OPTIONAL, for large collaborative projects where authors aren't listed
#size: 87654321 # OPTIONAL, the approximate size in bytes
#is_compressed: true # OPTIONAL, whether the size refers to a compressed file
#generation_time: 99999 # OPTIONAL, the approximate total time spent in generating the data in seconds on one CPU
code_location: "https://github.com/gnikylime/GameofSloanes" # OPTIONAL, location of the code used to generate the data
start_date: 2019 # OPTIONAL, approximate year when the project started
#end_date: 1935 # OPTIONAL, approximate date when the project was last updated (omit if the project seems to be ongoing)
accessible: true # OPTIONAL, data can still be accessed at location above (defaults to true)
#completeness: >
#  We include all foo up to order 42
  and all bar of order up to 5077 # OPTIONAL, a string describing the data's completeness, encouraged if it has the completeness_guarantee badge
#searchable: true # OPTIONAL, whether there is a search interface available at the location provided above
short_description: "A game to find putatively optimal packings in complex projective space with the goal of proving optimality of as many packings as possible." # OPTIONAL, at most one sentence, delimit with quotation marks
contact_email: asongofvectorsandangles@gmail.com # OPTIONAL, contact email for the database
authors: # OPTIONAL, can omit for large projects (in such case can include a single "author" with a collaboration email/webpage)
  - name: John Jasper
    homepage: "https://sites.google.com/view/john-jasper-math/"
    orcid: "https://orcid.org/0000-0002-4071-0934"
  - name: Emily J. King
    homepage: "https://www.math.colostate.edu/~king/"
    orcid: "https://orcid.org/0000-0002-4099-3401"
  - name: Dustin G. Mixon
    homepage: "https://people.math.osu.edu/mixon.23/"
references: # OPTIONAL, include as many as you like
#  - url: "https://other_databaase.com"
#  - doi: 10.0000/0000
  - arxiv: 1907.07848
#  - mr: 123456
  - paper: "John Jasper, Emily J. King, and Dustin G. Mixon.  Game of Sloanes: best known packings in complex projective space.  Wavelets and Sparsity XVIII 11138 (2019) pp. 416-425."
#  - issn: 12345678
#  - other: "Satellite imagery stored on Mars." # Please avoid; only use if none of the above are appropriate
tags: # OPTIONAL, see _data/tags.yml for a list of valid tags
  - arXiv.MG, arXiv.FA
#  - csv
badges: # OPTIONAL, see _data/badges.yml for a list of valid badges
  - collaborative
  - has_license
  - downloadable
  - citable
#  - completeness_guarantee
#  - cas_connection
#  - fm_connection
  - content_documentation
#  - schema3 # schema description quality: 3/3
#  - has_labels
#  - has_code # code that generates the data is available
---

A game to find putatively optimal packings in complex projective space with the goal of proving optimality of as many packings as possible.

This repository concerns the problem of packing n lines, represented by unit vectors, through the origin of C^d such that the angles between the lines are as large as possible. The problem has applications in fields such as compressed sensing, digital fingerprinting, quantum state tomography, and multiple description coding.
