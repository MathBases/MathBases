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
                <td class="centered-td"><a href="{{ p.id }}"><i class="fas fa-info-circle"></i></a></td>
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
				{% if r[0]=='arxiv' %}
	                                <a href="https://arxiv.org/abs/{{ r[1] }}" target="_blank">{{ r[0] }}</a>
				{% endif %}
				{% if r[0]!='arxiv' %}
	                                <a href="{{ r[1] }}">{{ r[0] }}</a>
				{% endif %}
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
