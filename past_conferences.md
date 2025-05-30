---
layout: plain
---
<h1 class="smallcaps">Past Conferences on Mathematical Databases</h1>

The following conferences are focused on mathematical databases generally, rather than a single area or system.  See also the list of [upcoming conferences](conferences).

<table class="display datatable">
  <thead>
    <tr>
      <th data-dt-order="disable">Info</th>
      <th>Name</th>
      <th>Dates</th>
      <th>Location</th>
    </tr>
  </thead>
  <tbody>
    {%- assign sorted = site.conferences | sort: "end" | reverse -%}
    {%- for c in sorted -%}
      {%- assign start_stamp = c.start | date: "%s" -%}
      {%- assign now_stamp = "now" | date: "%s" -%}
      {%- if start_stamp < now_stamp -%}
        {%- assign start = c.start | date: "%B %e, %Y" -%}
        {%- assign end = c.end | date: "%B %e, %Y" -%}
        {%- assign start_year = start | date: "%Y" -%}
        {%- assign end_year = end | date: "%Y" -%}
        {%- assign start_month = start | date: "%B" -%}
        {%- assign end_month = end | date: "%B" -%}
        {%- assign start_day = start | date: "%e" -%}
        {%- assign end_day = end | date: "%e" -%}
        <tr>
          <td class="centered-td"><a href="{{ c.id }}"><i class="fas fa-info-circle"></i></a></td>
          <td><a href="{{ c.homepage }}" target="_blank">{{ c.title }}<i class="fas fa-external-link-alt"></i></a></td>
          <td>
            {%- if start == end -%}
              {{ start }}
            {%- elsif start_year == end_year and start_month == end_month -%}
              {{start_month}} {{start_day}}-{{end_day}}, {{start_year}}
            {%- elsif start_year == end_year -%}
              {{ start_month }} {{start_day}}-{{end_month}} {{end_day}}, {{start_year}}
            {%- else %}
              {{start}} - {{end}}
            {%- endif %}
          </td>
          <td>{{ c.location }}</td>
        </tr>
      {%- endif -%}
    {%- endfor -%}
  </tbody>
</table>