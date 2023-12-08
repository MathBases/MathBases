---
layout: plain
---
<h1 class="smallcaps">Index of Mathematical DataBases</h1>
<table class="display datatable">
    <thead>
        <tr>
            <th>Info</th>
            <th>Name</th>
            <th>References</th>
            <th>Area</th>
            <th>Tags</th>
        </tr>
    </thead>
    <tbody>
        {% assign sorted = site.databases | sort: "title" %}
        {% for p in sorted %}
            <tr>
                <td><a href="{{ p.id }}">ⓘ</a></td>
                <td>
                    <a href="{{ p.location }}" target="_blank">
                        {{ p.title }}
                        <i class="fas fa-external-link-alt"></i>
                    </a>
                    {% if p.authors %}
                        {% assign authors = p.authors | map: "name" %}
                        <p>{{ authors | join: ", " }}</p>
                    {% endif %}
                </td>
                <td>
                    {% if p.references %}
                        {% for ref_hash in p.references %}
                            {% for r in ref_hash %}
                                <a href="{{ r[1] }}">{{ r[0] }}</a>
                            {% endfor %}
                        {% endfor %}
                    {% endif %}
                </td>
                <td>
                    {% if p.area %}
                    {% endif %}
                </td>
                <td>
                    {% if p.tags %}
                        {% for t in p.tags %}
                            {{ t }}
                        {% endfor %}
                    {% endif %}
                </td>
            </tr>
        {% endfor %}
    </tbody>
</table>