<!doctype html>
<html lang="nl">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Smart Filter - Klachten</title>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif; padding: 24px; background: #f5f7fb; color: #111827; }
    .sf-card { max-width: 720px; margin: 0 auto; background: #fff; padding: 18px; border-radius: 8px; box-shadow: 0 6px 20px rgba(15,23,42,0.06); }
    .sf-title { font-size: 18px; font-weight: 600; margin-bottom: 12px; }
    .sf-row { display:flex; gap:12px; align-items:flex-start; }
    .sf-input { flex:1; }
    .sf-input input { width:100%; padding:10px 12px; border-radius:6px; border:1px solid #e6ecef; font-size:14px; }
    .sf-dropdown { width: 320px; max-height: 320px; overflow:auto; border-radius:6px; border:1px solid #e6ecef; background:#ffffff; padding:6px; }
    .sf-item { padding:8px 10px; border-radius:4px; font-size:14px; cursor:pointer; color:#111827; }
    .sf-item:hover { background: #eef5f5; }
    .sf-item.hidden { display:none; }
    .sf-empty { padding:12px; color:#6b7280; }
  .sf-selected { margin-top:12px; font-size:14px; }
  .sf-selected-list { margin-top:10px; display:flex; gap:8px; flex-wrap:wrap; align-items:center; }
  .sf-selected-empty { color:#6b7280; }
  .sf-pill { display:inline-flex; align-items:center; gap:10px; background:#e7f6ee; color:#0f5132; padding:6px 10px; border-radius:18px; font-size:13px; }
  .sf-pill button { background:transparent; border:none; cursor:pointer; color:#0f5132; font-weight:700; padding:0 6px; }
  .sf-pill button:focus { outline:2px solid rgba(15,23,42,0.08); border-radius:12px; }
    mark { background: #fffbdd; color: #111827; padding:0 2px; border-radius:2px; }
    @media (max-width:800px) { .sf-row { flex-direction: column-reverse; } .sf-dropdown { width:100%; } }
  </style>
</head>
<body>

  <div class="sf-card">
    <div class="sf-title">Smart Filter - Klachten</div>
    <div class="sf-row">
      <div class="sf-input">
        <label for="sf-search">Zoeken</label>
        <input id="sf-search" type="text" placeholder="Typ om te filteren (bijv. 'P' of 'Poh')" autocomplete="off" />

        <!-- selected pills appear here -->
        <div id="sf-selected-list" aria-live="polite" class="sf-selected-list">
          <div class="sf-selected-empty">Geselecteerd: <em>geen</em></div>
        </div>
      </div>
      <div class="sf-dropdown" id="sf-dropdown" role="listbox" aria-label="Lijst met diagnoses">
        <!-- items rendered by JS -->
      </div>
    </div>
  </div>

  <script>
    // Diagnoses array from PHP
    var DIAGNOSES = <?php echo json_encode(array_values($diagnoses), JSON_UNESCAPED_UNICODE); ?>;

    var dropdown = document.getElementById('sf-dropdown');
    var input = document.getElementById('sf-search');
    var selectedListEl = document.getElementById('sf-selected-list');

    // currently selected diagnoses (strings)
    var SELECTED = [];

    // Render list of items; highlight matches using simple mark wrapping
    function renderList(filter) {
      var q = (filter || '').toString().toLowerCase();
      dropdown.innerHTML = '';
      var count = 0;
      for (var i = 0; i < DIAGNOSES.length; i++) {
        var text = DIAGNOSES[i];
        var textLower = text.toLowerCase();
        if (q === '' || textLower.indexOf(q) !== -1) {
          count++;
          var item = document.createElement('div');
          item.className = 'sf-item';
          item.setAttribute('role','option');
          item.setAttribute('data-value', text);

          // indicate if this item is already selected
          if (SELECTED.indexOf(text) !== -1) {
            item.classList.add('sf-item--selected');
            item.innerHTML = '✓&nbsp;&nbsp;' + escapeHtml(text);
          } else if (q !== '') {
            // highlight the matching substring(s)
            var esc = q.replace(/[.*+?^${}()|[\\]\\]/g, '\\$&');
            var re = new RegExp(esc, 'ig');
            var highlighted = text.replace(re, function(m){ return '<mark>' + m + '</mark>'; });
            item.innerHTML = highlighted;
          } else {
            item.textContent = text;
          }

          // click toggles selection
          (function(t){
            item.addEventListener('click', function(){
              toggleSelection(t);
              input.value = '';
              renderList('');
            });
          })(text);
          dropdown.appendChild(item);
        }
      }
      if (count === 0) {
        var empty = document.createElement('div');
        empty.className = 'sf-empty';
        empty.textContent = 'Geen resultaten';
        dropdown.appendChild(empty);
      }
    }

    function escapeHtml(s) {
      return s.replace(/[&<>\"]/g, function(c){ return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'})[c]; });
    }

    function renderSelected() {
      selectedListEl.innerHTML = '';
      if (SELECTED.length === 0) {
        var em = document.createElement('div');
        em.className = 'sf-selected-empty';
        em.textContent = 'Geselecteerd: geen';
        selectedListEl.appendChild(em);
        return;
      }
      SELECTED.forEach(function(item){
        var pill = document.createElement('div');
        pill.className = 'sf-pill';
        pill.setAttribute('data-value', item);
        var span = document.createElement('span');
        span.innerHTML = escapeHtml(item);
        var btn = document.createElement('button');
        btn.setAttribute('aria-label', 'Verwijder ' + item);
        btn.innerHTML = '✕';
        btn.addEventListener('click', function(e){
          e.stopPropagation();
          removeSelection(item);
        });
        pill.appendChild(span);
        pill.appendChild(btn);
        selectedListEl.appendChild(pill);
      });
    }

    function toggleSelection(value) {
      var idx = SELECTED.indexOf(value);
      if (idx === -1) {
        SELECTED.push(value);
      } else {
        SELECTED.splice(idx,1);
      }
      renderSelected();
    }

    function removeSelection(value) {
      var idx = SELECTED.indexOf(value);
      if (idx !== -1) SELECTED.splice(idx,1);
      renderSelected();
    }

    // live filter on input (immediate)
    input.addEventListener('input', function(e){
      var v = e.target.value;
      renderList(v);
      selectedEl.innerHTML = 'Geselecteerd: <em>geen</em>';
    });

    // open dropdown on focus
    input.addEventListener('focus', function(){ renderList(input.value); });

    // initial render
    renderList('');
  </script>

</body>
</html>
