---
layout: plain
---
<h1 class="smallcaps" id="imdb_title">Index of Mathematical DataBases</h1>
<table class="display datatable" data-order-columns="[1]">
    <thead>
        <tr>
            <th data-dt-order="disable">Info</th>
            <th data-hide-column="true">Ascii Name</th>
            <th>Name</th>
            <th>References</th>
            <th>Area</th>
            <th>Tags</th>
            <th data-hide-column="true">Description</th>
        </tr>
    </thead>
    <tbody>
        {%- assign sorted = site.databases | sort: "title" -%}
        {%- for p in sorted -%}
            <tr>
                <td class="centered-td"><a href="{{ p.id }}"><i class="fas fa-info-circle"></i></a></td>
                <td>
                    {%- if p.ascii_name -%}
                    {{ p.ascii_name }}
                    {%- else -%}
                    {{ p.title }}
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.accessible != null and p.accessible == false -%}
                    {{ p.title }} (no longer online)
                    {%- else -%}
                    <a href="{{ p.location }}" target="_blank">
                        {{ p.title }}
                        <i class="fas fa-external-link-alt"></i>
                    </a>
                    {%- endif -%}
                    {%- if p.authors -%}
                        {%- assign authors = p.authors -%}
                        <ul class="authors-list">
                        {%- for author in authors -%}
                        <li>{%- if author.homepage -%}<a href="{{ author.homepage}}">{{author.name}}</a> {%- else -%} {{ author.name }} {%- endif -%}</li>
                        {%- endfor -%}
                        </ul>
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.references -%}
                        <ul class="reference-list">
                        {%- for ref_hash in p.references -%}
                            {%- for r in ref_hash -%}
                                {%- assign ref_type = r[0] -%}
                                <li>
                                {%- case ref_type -%}
                                {%- when "arxiv" -%}
                                    <a href="https://arxiv.org/abs/{{ r[1] }}" target="_blank">arXiv</a>
                                {%- when "doi" -%}
                                    <a href="https://doi.org/{{ r[1] }}" target="_blank">DOI</a>
                                {%- when "eprint" -%}
                                    <a href="https://eprint.iacr.org/{{ r[1] }}" target="_blank">ePrint</a>
                                {%- when "rg" -%}
                                    <a href="https://www.researchgate.net/publication/{{ r[1] }}" target="_blank">RG</a>
                                {%- when "isbn" -%}
                                    <a href="https://www.google.com/search?tbm=bks&q=isbn:{{ r[1] }}" target="_blank">ISBN</a>
                                {%- else -%}
                                    <a href="{{ r[1] }}">{{ r[0] }}</a>
                                {%- endcase -%}
                                </li>
                            {%- endfor -%}
                        {%- endfor -%}
                        </ul>
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.area -%}
                       <ul class="area-list">
                       {%- for a in p.area -%}
                           <li>{{ a }}</li>
                       {%- endfor -%}
                       </ul>
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.tags -%}
                        <ul class="tag-list">
                        {%- for t in p.tags -%}
                            <li>{{ t }}</li>
                        {%- endfor -%}
                        </ul>
                    {%- endif %}
                </td>
                <td>
                  {%- if p.short_description -%}
                    {{ p.short_description }}
                  {%- endif -%}
                </td>
            </tr>
        {%- endfor -%}
    </tbody>
</table>
