---
layout: plain
---
<h1 class="smallcaps">Ideas for Mathematical DataBases</h1>
<table class="display datatable">
  <thead>
    <tr>
      <th data-dt-order="disable">Info</th>
      <th>Name</th>
      <th>Area</th>
      <th>Tags</th>
    </tr>
  </thead>
  <tbody>
    {%- assign sorted = site.ideas | sort: "title" -%}
    {%- for idea in sorted -%}
      <tr>
        <td class="centered-td"><a href="{{ idea.id }}"><i class="fas fa-info-circle"></i></a></td>
        <td>{{ idea.title }}</td>
        <td>
          {%- if idea.area -%}
            {% for a in idea.area -%}
              {% if forloop.index0 != 0 %}, {% endif %} {{ a }}
            {% endfor %}
          {%- endif -%}
        </td>
        <td>
          {%- if idea.tags -%}
            {%- for t in idea.tags -%}
              {% if forloop.index0 != 0 %}, {% endif %} {{ t }}
            {%- endfor -%}
          {%- endif %}
        </td>
        <td>
          {%- if idea.short_description -%}
            {{ p.short_description }}
          {%- endif -%}
        </td>
      </tr>
    {%- endfor -%}
  </tbody>
</table>