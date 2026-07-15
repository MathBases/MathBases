---
layout: plain
---
<h1 class="smallcaps" id="imdb_title">Index of Mathematical DataBases</h1>
<!-- Area filter (issue #86). JS moves #area-filter-control next to the DataTables
     search box and #area-filter-chips-row onto its own row below them. -->
<div id="area-filter-control" class="area-filter-control" hidden>
    <button type="button" id="area-filter-toggle" class="area-filter-toggle" aria-expanded="false" aria-controls="area-filter-menu">
        Filter by area <span class="area-filter-caret" aria-hidden="true">&#9662;</span>
    </button>
    <div id="area-filter-menu" class="area-filter-menu" role="group" aria-label="Filter by area" hidden>
        {%- for area in site.data.areas.areas -%}
            {%- assign n = 0 -%}
            {%- for p in site.databases -%}
                {%- if p.area contains area -%}{%- assign n = n | plus: 1 -%}{%- endif -%}
            {%- endfor -%}
            {%- if n > 0 -%}
            <label class="area-filter-opt" data-count="{{ n }}">
                <input type="checkbox" value="{{ area }}">
                <span class="area-filter-name">{{ area }}</span>
                <span class="area-filter-cnt">{{ n }}</span>
            </label>
            {%- endif -%}
        {%- endfor -%}
    </div>
</div>
<div id="area-filter-chips-row" class="area-filter-chips-row" hidden>
    <span id="area-filter-chips" class="area-filter-chips"></span>
    <button type="button" id="area-filter-clear" class="area-filter-clear" hidden>clear</button>
</div>
<table id="imdb_table" class="display datatable" data-order-columns="[1]">
    <thead>
        <tr>
            <th data-dt-order="disable">Info</th>
            <th data-hide-column="true">Sort Key</th>
            <th>Name</th>
            <th>References</th>
            <th>Area</th>
            <th>Tags</th>
            <th data-hide-column="true">Description</th>
        </tr>
    </thead>
    <tbody>
        {%- comment -%} Sort by the generated sort key (issue #75), which drops
            leading articles and non-letters; fall back to the title. Liquid can't
            attach the _data key to each record for a native sort, so build
            "key@@@index" strings, sort them, and map back to site.databases. {%- endcomment -%}
        {%- assign sort_pairs = "" -%}
        {%- for p in site.databases -%}
            {%- assign key = site.data.sort_keys[p.slug] | default: p.title | downcase -%}
            {%- assign sort_pairs = sort_pairs | append: key | append: "@@@" | append: forloop.index0 | append: "|||" -%}
        {%- endfor -%}
        {%- assign sorted_pairs = sort_pairs | split: "|||" | sort -%}
        {%- for pair in sorted_pairs -%}
            {%- assign idx = pair | split: "@@@" | last | times: 1 -%}
            {%- assign p = site.databases[idx] -%}
            <tr>
                <td class="centered-td"><a href="{{ p.id }}"><i class="fas fa-info-circle"></i></a></td>
                <td>{{ site.data.sort_keys[p.slug] | default: p.title | downcase }}</td>
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
    var STORAGE_KEY = 'mathbases:areaFilter';
    var AREA_COL = 4; // Info, Ascii Name, Name, References, Area, Tags, Description

    function ready(fn) {
        if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', fn); }
        else { fn(); }
    }

    ready(function () {
        var tableEl = document.getElementById('imdb_table');
        var control = document.getElementById('area-filter-control');
        if (!tableEl || !control || typeof DataTable === 'undefined') { return; }

        // custom.html builds the DataTable on jQuery's async ready, which runs
        // after this handler, so poll until it exists, then only ever RETRIEVE
        // it (creating it here would win the race and drop custom.html's config).
        var tries = 0;
        (function whenReady() {
            if (DataTable.isDataTable(tableEl)) { setup(new DataTable(tableEl)); }
            else if (tries++ < 200) { setTimeout(whenReady, 30); } // setTimeout, not rAF: rAF is paused in background tabs
        })();

        function setup(table) {
            var toggle   = document.getElementById('area-filter-toggle');
            var menu     = document.getElementById('area-filter-menu');
            var chipsRow = document.getElementById('area-filter-chips-row');
            var chips    = document.getElementById('area-filter-chips');
            var clear    = document.getElementById('area-filter-clear');
            var wrapper  = tableEl.closest('.dataTables_wrapper');
            var search   = wrapper ? wrapper.querySelector('.dataTables_filter') : null;

            // Order options by frequency (desc), then name (asc).
            Array.prototype.slice.call(menu.querySelectorAll('.area-filter-opt'))
                .sort(function (a, b) {
                    var d = (+b.getAttribute('data-count')) - (+a.getAttribute('data-count'));
                    return d || a.querySelector('.area-filter-name').textContent
                        .localeCompare(b.querySelector('.area-filter-name').textContent);
                })
                .forEach(function (o) { menu.appendChild(o); });

            // Place the control just left of the search box in a shared toolbar,
            // with the selected-area chips on their own row just below.
            if (search) {
                var toolbar = document.createElement('div');
                toolbar.className = 'index-toolbar';
                search.parentNode.insertBefore(toolbar, search);
                toolbar.appendChild(control);
                toolbar.appendChild(search);
                toolbar.parentNode.insertBefore(chipsRow, toolbar.nextSibling);
            }

            function escapeRegExp(s) { return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); }
            function boxes() { return Array.prototype.slice.call(menu.querySelectorAll('input[type=checkbox]')); }
            function selectedAreas() {
                return boxes().filter(function (c) { return c.checked; }).map(function (c) { return c.value; });
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

            function save(areas) {
                try { window.localStorage.setItem(STORAGE_KEY, JSON.stringify(areas)); } catch (e) {}
            }
            function load() {
                try { return JSON.parse(window.localStorage.getItem(STORAGE_KEY)) || []; } catch (e) { return []; }
            }

            function applyFilter(persist) {
                var areas = selectedAreas();
                if (areas.length === 0) {
                    table.column(AREA_COL).search('').draw();
                } else {
                    var re = '\\|(?:' + areas.map(escapeRegExp).join('|') + ')\\|';
                    table.column(AREA_COL).search(re, true, false).draw();
                }
                renderChips(areas);
                clear.hidden = areas.length === 0;
                chipsRow.hidden = areas.length === 0;
                toggle.classList.toggle('has-selection', areas.length > 0);
                if (persist !== false) { save(areas); }
            }

            function openMenu(open) {
                menu.hidden = !open;
                toggle.setAttribute('aria-expanded', String(open));
            }

            toggle.addEventListener('click', function (e) { e.stopPropagation(); openMenu(menu.hidden); });
            menu.addEventListener('click', function (e) { e.stopPropagation(); });
            menu.addEventListener('change', function (e) {
                if (e.target && e.target.type === 'checkbox') { applyFilter(); }
            });
            chips.addEventListener('click', function (e) {
                var chip = e.target.closest('.area-filter-chip');
                if (!chip) { return; }
                var a = chip.getAttribute('data-area');
                boxes().forEach(function (c) { if (c.value === a) { c.checked = false; } });
                applyFilter();
            });
            clear.addEventListener('click', function () {
                boxes().forEach(function (c) { c.checked = false; });
                applyFilter();
            });
            document.addEventListener('click', function () { openMenu(false); });

            // Restore the persisted selection, then reflect it without re-saving.
            var saved = load();
            if (saved.length) {
                var set = {};
                saved.forEach(function (a) { set[a] = true; });
                boxes().forEach(function (c) { if (set[c.value]) { c.checked = true; } });
            }
            applyFilter(false);

            control.hidden = false; // reveal now that it's wired up and placed
        }
    });
})();
</script>
