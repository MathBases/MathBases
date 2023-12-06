


<ul>
  {% assign sorted = site.databases | sort: "name" %}
  {% for p in sorted %}
    {% unless p.private %}
    <li>
      <div>
        <h4>
          <a href="{{p.url}}" target="_blank">
            {{p.name}}
          </a>
        </h4>
        {% for badge_id in p.badges %}
          {% assign badge = site.data.badges[badge_id] %}
          <img src="{{badge.img}}" alt="{{badge.name}} : {{badge.description}}" width=100 height=100>
        {% endfor %}
        <p>
          {{ p.content | markdownify }}
        </p>
      </div>
    </li>
    {% endunless %}
  {% endfor %}
</ul>
