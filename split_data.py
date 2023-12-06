#!/usr/bin/env python

from collections import Counter
import re

def parse_author(line):
    line = line.replace("* ", "").strip()
    if line[0] == "[" and line[-1] == ")":
        name, homepage = line[1:-1].split("](")
    else:
        name, homepage = line, None
    return name, homepage

def get_records():
    records = []
    with open("DATA.md") as F:
        buff = []
        rec = {}
        for line in F:
            if line.startswith("# "):
                continue
            elif line.startswith("## "):
                if rec:
                    comment = "\n".join(buff)
                    if comment != "N/A":
                        rec["comment"] = comment
                    buff = []
                    records.append(rec)
                    rec = {}
                rec["name"] = line[2:].strip()
            elif any(line.startswith(f"* {k}: ") for k in ["Website", "Number of objects", "Number of datasets", "Number of contributors", "Size when compressed", "Size (uncompressed)", "Time to generate", "Completeness", "Collaborative", "Searchable"]):
                k, v = line[2:].strip().split(": ", 1)
                if v == "N/A":
                    continue
                rec[k] = v
            elif line.startswith("### Author"):
                desc = "\n".join(buff).strip()
                if desc != "N/A":
                    rec["description"] = desc
                buff = []
            elif line.startswith("### Tag"):
                rec["authors"] = [parse_author(line) for line in buff]
                buff = []
            elif line.startswith("### Reference"):
                assert len(buff) <= 1
                if buff:
                    rec["tags"] = buff[0].split(", ")
                buff = []
            elif line.startswith("### Comment"):
                if buff:
                    rec["references"] = [line.replace("* ", "").strip() for line in buff]
                    buff = []
            else:
                line = line.strip()
                if line:
                    buff.append(line)
        comment = "\n".join(buff)
        if comment != "N/A":
            rec["comment"] = comment
        buff = []
        records.append(rec)
    return records

def get_id(name, website):
    # Two disambiguations
    if name == "Combinatorial Data":
        if website == "http://users.monash.edu.au/~iwanless/data/":
            return "combinatorial_data_iw"
        else:
            return "combinatorial_data_bm"
    name = name.lower()
    trim = re.sub("<=", "le", name)
    trim = re.sub("[^a-z0-9 ]", "", trim)
    trim = re.sub("the ", "", trim)
    trim = re.sub("^(an )?atlas of ", "", trim)
    trim = re.sub("^lists of ", "", trim)
    trim = re.sub("^a census of ", "", trim)
    trim = re.sub("^(a )?(online )?database of ", "", trim)
    trim = re.sub("^table of ", "", trim)
    trim = re.sub("^homepage of ", "", trim)
    trim = re.sub("^(a )?catalog(ue)? of ", "", trim)
    trim = re.sub(" databases?$", "", trim)
    trim = re.sub(" datasets?$", "", trim)
    trim = re.sub(" library$", "", trim)
    trim = re.sub(" tables?$", "", trim)
    trim = re.sub(" catalog(ue)?$", "", trim)
    trim = re.sub("of ", "", trim)
    return "_".join(trim.split(" ")[:4])

def write_records():
    records = get_records()
    ids = [get_id(rec["name"], rec["website"]) for rec in records]
    C = Counter(ids)
    bad = {id: cnt for (id, cnt) in C.items() if cnt > 1}
    print(bad)
