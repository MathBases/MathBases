---
layout: plain
---
<h1 class="smallcaps">Index of Mathematical DataBases</h1>
<table class="display datatable" data-order-columns="[1]">
    <thead>
        <tr>
            <th>Info</th>
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
                    <a href="{{ p.location }}" target="_blank">
                        {{ p.title }}
                        <i class="fas fa-external-link-alt"></i>
                    </a>
                    {%- if p.authors -%}
                        {%- assign authors = p.authors | map: "name" -%}
                        <p>{{ authors | join: ", " }}</p>
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.references -%}
                        {%- for ref_hash in p.references -%}
                            {%- for r in ref_hash -%}
                                {%- assign ref_type = r[0] -%}
                                {%- case ref_type -%}
                                {%- when "arxiv" -%}
                                    <a href="https://arxiv.org/abs/{{ r[1] }}" target="_blank">{{ ref_type }}</a>
                                {%- when "doi" -%}
                                    <a href="https://doi.org/{{ r[1] }}" target="_blank">{{ ref_type }}</a>
                                {%- when "rg" -%}
                                    <a href="https://www.researchgate.net/publication/{{ r[1] }}" target="_blank">{{ ref_type }}</a>
                                {%- when "isbn" -%}
                                    {{ r[1] }}
                                {%- else -%}
                                    <a href="{{ r[1] }}">{{ r[0] }}</a>
                                {%- endcase -%}
                            {%- endfor -%}
                        {%- endfor -%}
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.area -%}
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.tags -%}
                        {%- for t in p.tags -%}
                            {{ t }}
                        {%- endfor %}
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
