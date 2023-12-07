---
layout: table
tableid: test
---

<table id="test" class="display mainTable">
    <thead>
        <tr>
            <th>Column 1</th>
            <th>Column 2</th>
        </tr>
    </thead>
    <tbody>
        {% assign sorted = site.databases | sort: "name" %}
  {% for p in sorted %}
    {% unless p.private %}
    <tr>
        <td>
          <a href="{{p.url}}" target="_blank">
            {{p.name}}
          </a>
        </td>
        <td>
            {{p.authors[0].name}}
        </td>
    </tr>
    {% endunless %}
  {% endfor %}
    </tbody>
</table>