---
layout: plain
---
<h1 class="smallcaps">Upcoming Conferences on Mathematical Databases</h1>

The following conferences are focused on mathematical databases generally, rather than a single area or system.  See also the list of [past conferences](past_conferences).

<table class="display datatable">
  <thead>
    <tr>
      <th data-dt-order="disable">Info</th>
      <th>Name</th>
      <th>Dates</th>
      <th>Location</th>
      <th>Abstract deadline</th>
    </tr>
  </thead>
  <tbody>
    {%- assign sorted = site.conferences | sort: "start" -%}
    {%- for c in sorted -%}
      {%- assign end_stamp = c.end | date: "%s" -%}
      {%- assign now_stamp = "now" | date: "%s" -%}
      {%- if end_stamp > now_stamp -%}
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
          <td>{%- if c.abstract_deadline -%}{{ c.abstract_deadline | date: "%B %e, %Y" }}{%- endif -%}</td>
        </tr>
      {%- endif -%}
    {%- endfor -%}
  </tbody>
</table>