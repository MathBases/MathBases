#!/usr/bin/env python

from collections import Counter
import re
import yaml

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
            return "combinatorial-data-iw"
        else:
            return "combinatorial-data-bm"
    elif name == "A Database for Number Fields":
        return "number-fields-km"
    elif name == "Database of Number Fields":
        return "number-fields-jr"
    elif name == "An Atlas of Graphs":
        return "atlas-graphs"
    elif name == "Encyclopedia of Graphs":
        return "encyclopedia-graphs"
    elif name == "FindStat (The Combinatorial Statistic Finder)":
        return "findstat"
    elif name == "LMFDB, the database of L-functions, modular forms, and related objects":
        return "lmfdb"
    name = name.lower()
    trim = re.sub("<=", "le", name)
    trim = re.sub(".org", " ", trim)
    trim = re.sub("π", "pi", trim)
    trim = re.sub(" - ", " ", trim)
    trim = re.sub("[^a-z0-9- ]", "", trim)
    while "  " in trim:
        trim = re.sub("  ", " ", trim)
    trim = re.sub("the ", "", trim)
    trim = re.sub(" of ", " ", trim)
    trim = re.sub(" for ", " ", trim)
    trim = re.sub(" in ", " ", trim)
    trim = re.sub(" and ", " ", trim)
    trim = re.sub(" with ", " ", trim)
    trim = re.sub(" a ", " ", trim)
    trim = re.sub(" an ", " ", trim)
    trim = re.sub("^(an )?atlas ", "", trim)
    trim = re.sub("^lists ", "", trim)
    trim = re.sub("^classification ", "", trim)
    trim = re.sub("^a census ", "", trim)
    trim = re.sub("^(an )?(online )?encyclopedia ", "", trim)
    trim = re.sub("^(a )?(online )?database ", "", trim)
    trim = re.sub("^table ", "", trim)
    trim = re.sub("^homepage ", "", trim)
    trim = re.sub("^(a )?catalog(ue)? ", "", trim)
    trim = re.sub(" databases?$", "", trim)
    trim = re.sub(" datasets?$", "", trim)
    trim = re.sub(" library$", "", trim)
    trim = re.sub(" tables?$", "", trim)
    trim = re.sub(" catalog(ue)?$", "", trim)
    return "-".join(trim.split(" ")[:4])

def write_records():
    records = get_records()
    names = [rec["name"] for rec in records]
    ids = [get_id(rec["name"], rec.get("Website")) for rec in records]
    C = Counter(ids)
    assert max(C.values()) == 1
    #for id, name in zip(ids, names):
    #    print(f"{id:50}{name}")
    for id, rec in zip(ids, records):
        yml = {}
        yml["id"] = id
        yml["title"] = rec["name"]
        if "Website" in rec:
            yml["location"] = rec['Website']
        if "Number of objects" in rec:
            yml["objects"] = int(rec['Number of objects'])
        if "Number of datasets" in rec and rec["Number of datasets"] != "1":
            yml["datasets"] = int(rec['Number of datasets'])
        if "Number of contributors" in rec:
            yml["contributors"] = rec['Number of contributors']
        # omit size for now
        # omit time to generate for now
        # skipping completeness for now
        # skipping collaborative for now
        # skipping searchable for now
        if rec.get("authors"):
            yml["authors"] = []
            for name, homepage in rec["authors"]:
                if homepage:
                    yml["authors"].append({"name": name, "homepage": homepage})
                else:
                    yml["authors"].append({"name": name})
        if rec.get("tags"):
            yml["tags"] = rec["tags"]
        if rec.get("references"):
            yml["references"] = []
            for ref in rec["references"]:
                typ, url = ref.split(":", 1)
                if url.startswith("arxiv:"):
                    url = url.replace("arxiv:", "")
                yml["references"].append({typ: url})
        with open(f"_databases/{id}.md", "w") as F:
            yml = f"---\n{yaml.dump(yml)}\n"
            if rec.get("description"):
                yml += f"""---

{rec['description']}
"""
            else:
                yml += "---\n\n"
            _ = F.write(yml)
    #return list(zip(ids, names))
