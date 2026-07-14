---
id: number-fields-pari
location: "https://pari.math.u-bordeaux.fr/pub/pari/packages/nftables/"
title: Bordeaux number field tables (nftables)
area:
  - number theory
num_objects: 1153447
size: 8392692
is_compressed: true
start_date: 1995
end_date: 2008
short_description: "The corrected Bordeaux ('megrez') tables of 1.15 million number fields of degrees 2-7, with discriminant, defining polynomial, class number and class group."
authors:
  - name: Henri Cohen
    homepage: "https://www.math.u-bordeaux.fr/~hecohen/"
  - name: Francisco Diaz y Diaz
  - name: Michel Olivier
  - name: Karim Belabas
    homepage: "https://www.math.u-bordeaux.fr/~kbelabas/"
tags:
  - number fields
  - class groups
  - discriminants
---

GP-format tables (one file per degree and signature, readable directly by PARI/GP) of number fields of degrees 2 through 7 within signature-dependent discriminant bounds, totalling 1,153,447 fields. Each entry records the discriminant, defining polynomial coefficients, class number and class group elementary divisors. This is a stripped-down, corrected version (with an explicit erratum list) of the tables computed by the Bordeaux computational number theory group around 1995, repackaged for the PARI group in 2007. These ranges are largely subsumed by the LMFDB global number field database.
