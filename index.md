---
layout: plain
---
<h1 class="smallcaps" id="imdb_title">Index of Mathematical DataBases</h1>
<div id="area-filter" class="area-filter" hidden>
    <button type="button" id="area-filter-toggle" class="area-filter-toggle" aria-expanded="false" aria-controls="area-filter-menu">
        Filter by area <span class="area-filter-caret" aria-hidden="true">&#9662;</span>
    </button>
    <span id="area-filter-chips" class="area-filter-chips"></span>
    <button type="button" id="area-filter-clear" class="area-filter-clear" hidden>clear</button>
    <div id="area-filter-menu" class="area-filter-menu" role="group" aria-label="Filter by area" hidden>
        {%- for area in site.data.areas.areas -%}
            {%- assign n = 0 -%}
            {%- for p in site.databases -%}
                {%- if p.area contains area -%}{%- assign n = n | plus: 1 -%}{%- endif -%}
            {%- endfor -%}
            {%- if n > 0 -%}
            <label class="area-filter-opt">
                <input type="checkbox" value="{{ area }}">
                <span class="area-filter-name">{{ area }}</span>
                <span class="area-filter-cnt">{{ n }}</span>
            </label>
            {%- endif -%}
        {%- endfor -%}
    </div>
</div>
<table id="imdb_table" class="display datatable" data-order-columns="[1]">
    <thead>
        <tr>
            <th data-dt-order="disable">Info</th>
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
                    {%- if p.accessible != null and p.accessible == false -%}
                    {{ p.title }} (no longer online)
                    {%- else -%}
                    <a href="{{ p.location }}" target="_blank">
                        {{ p.title }}
                        <i class="fas fa-external-link-alt"></i>
                    </a>
                    {%- endif -%}
                    {%- if p.authors -%}
                        {%- assign authors = p.authors -%}
                        <ul class="authors-list">
                        {%- for author in authors -%}
                        <li>{%- if author.homepage -%}<a href="{{ author.homepage}}">{{author.name}}</a> {%- else -%} {{ author.name }} {%- endif -%}</li>
                        {%- endfor -%}
                        </ul>
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.references -%}
                        <ul class="reference-list">
                        {%- for ref_hash in p.references -%}
                            {%- for r in ref_hash -%}
                                {%- assign ref_type = r[0] -%}
                                <li>
                                {%- case ref_type -%}
                                {%- when "arxiv" -%}
                                    <a href="https://arxiv.org/abs/{{ r[1] }}" target="_blank">arXiv</a>
                                {%- when "doi" -%}
                                    <a href="https://doi.org/{{ r[1] }}" target="_blank">DOI</a>
                                {%- when "eprint" -%}
                                    <a href="https://eprint.iacr.org/{{ r[1] }}" target="_blank">ePrint</a>
                                {%- when "rg" -%}
                                    <a href="https://www.researchgate.net/publication/{{ r[1] }}" target="_blank">RG</a>
                                {%- when "isbn" -%}
                                    <a href="https://www.google.com/search?tbm=bks&q=isbn:{{ r[1] }}" target="_blank">ISBN</a>
                                {%- else -%}
                                    <a href="{{ r[1] }}">{{ r[0] }}</a>
                                {%- endcase -%}
                                </li>
                            {%- endfor -%}
                        {%- endfor -%}
                        </ul>
                    {%- endif -%}
                </td>
                <td data-search="{%- if p.area -%}|{{ p.area | join: '|' }}|{%- endif -%}">
                    {%- if p.area -%}
                       <ul class="area-list">
                       {%- for a in p.area -%}
                           <li>{{ a }}</li>
                       {%- endfor -%}
                       </ul>
                    {%- endif -%}
                </td>
                <td>
                    {%- if p.tags -%}
                        <ul class="tag-list">
                        {%- for t in p.tags -%}
                            <li>{{ t }}</li>
                        {%- endfor -%}
                        </ul>
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

<script>
// Custom "filter by area" control for the index table (issue #86).
// Areas are multi-valued, so each row's Area cell carries a delimited
// data-search value ("|area one|area two|"); we filter the Area column with a
// regex that matches any selected area between pipes.
//
// NB: the minimal-mistakes theme bundles its own jQuery which replaces the one
// loaded in head/custom.html, so DataTables is only reachable via the global
// `DataTable` (as in custom.html), not $.fn.dataTable. Hence: plain DOM + the
// global constructor, no jQuery dependency.
(function () {
    function init() {
        var AREA_COL = 4; // Info, Ascii Name, Name, References, Area, Tags, Description
        var tableEl = document.getElementById('imdb_table');
        if (!tableEl || typeof DataTable === 'undefined') { return; }
        // Retrieve (never create) the instance custom.html builds. custom.html
        // initialises on jQuery's async ready, which runs after this native
        // DOMContentLoaded handler, so we must not `new DataTable` it ourselves
        // (that would win the race and drop custom.html's paging/search config).
        var table = null;
        function getTable() {
            if (!table && DataTable.isDataTable(tableEl)) { table = new DataTable(tableEl); }
            return table;
        }

        var filter = document.getElementById('area-filter');
        var toggle = document.getElementById('area-filter-toggle');
        var menu   = document.getElementById('area-filter-menu');
        var chips  = document.getElementById('area-filter-chips');
        var clear  = document.getElementById('area-filter-clear');

        function escapeRegExp(s) { return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); }

        function selectedAreas() {
            return Array.prototype.slice.call(menu.querySelectorAll('input:checked'))
                .map(function (c) { return c.value; });
        }

        function renderChips(areas) {
            chips.textContent = '';
            areas.forEach(function (a) {
                var chip = document.createElement('button');
                chip.type = 'button';
                chip.className = 'area-filter-chip';
                chip.setAttribute('data-area', a);
                chip.textContent = a;
                var x = document.createElement('span');
                x.className = 'area-filter-chip-x';
                x.setAttribute('aria-hidden', 'true');
                x.textContent = '×';
                chip.appendChild(x);
                chips.appendChild(chip);
            });
        }

        function applyFilter() {
            var t = getTable();
            if (!t) { return; }
            var areas = selectedAreas();
            if (areas.length === 0) {
                t.column(AREA_COL).search('').draw();
            } else {
                var re = '\\|(?:' + areas.map(escapeRegExp).join('|') + ')\\|';
                t.column(AREA_COL).search(re, true, false).draw();
            }
            renderChips(areas);
            clear.hidden = areas.length === 0;
            toggle.classList.toggle('has-selection', areas.length > 0);
        }

        function openMenu(open) {
            menu.hidden = !open;
            toggle.setAttribute('aria-expanded', String(open));
        }

        toggle.addEventListener('click', function (e) {
            e.stopPropagation();
            openMenu(menu.hidden);
        });
        menu.addEventListener('click', function (e) { e.stopPropagation(); });
        menu.addEventListener('change', function (e) {
            if (e.target && e.target.type === 'checkbox') { applyFilter(); }
        });
        chips.addEventListener('click', function (e) {
            var chip = e.target.closest('.area-filter-chip');
            if (!chip) { return; }
            var a = chip.getAttribute('data-area');
            Array.prototype.slice.call(menu.querySelectorAll('input')).forEach(function (c) {
                if (c.value === a) { c.checked = false; }
            });
            applyFilter();
        });
        clear.addEventListener('click', function () {
            Array.prototype.slice.call(menu.querySelectorAll('input:checked'))
                .forEach(function (c) { c.checked = false; });
            applyFilter();
        });
        document.addEventListener('click', function () { openMenu(false); });

        filter.hidden = false; // reveal now that behaviour is wired up
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
</script>
