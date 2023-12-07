---
layout: table
tableid: test
---

<table id="test" class="display">
    <thead>
        <tr>
            <th>Name</th>
            <th>ID</th>
        </tr>
    </thead>
    <tbody>
        {% assign sorted = site.databases | sort: "title" %}
        {% for p in sorted %}
            {% unless p.private %}
            <tr>
                <td>
                <a href="{{p.url}}" target="_blank">
                    {{p.title}}
                </a>
                </td>
                <td>
                    {{p.id}}
                </td>
            </tr>
            {% endunless %}
        {% endfor %}
    </tbody>
</table>