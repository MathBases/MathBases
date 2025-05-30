---
layout: plain
---

Stubs have been written by [editorial board](board.html) as placeholders, and we welcome improved versions.  Submissions will undergo a [review process](contributing) before publication.  Depending on the topic, we may ask authors to periodically update the content occasionally to account in changes in development practices.

<h1 class="smallcaps">Existing stubs</h1>

<table class="display datatable">
  <tbody>
    {%- assign sorted = site.articles | sort: "title" -%}
    {%- for A in sorted -%}
      {%- if A.author == "stub" -%}
        <tr>
          <td><a href="{{ A.id }}">{{ A.title }}</a></td>
        </tr>
      {% endif %}
    {%- endfor -%}
  </tbody>
</table>