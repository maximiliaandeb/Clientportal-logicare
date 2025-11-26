<div class="cp-v2-root">
    <div class="cp-v2-layout">

        <aside class="cp-v2-left">
            <?php include __DIR__ . '/left-sidebar.tpl'; ?>
        </aside>

        <main class="cp-v2-main">
            <?php include __DIR__ . '/main-card.tpl'; ?>
        </main>

        <aside class="cp-v2-right">
            <?php include __DIR__ . '/vragenlijsten.tpl'; ?>
            <?php include __DIR__ . '/facturen.tpl'; ?>
            <?php include __DIR__ . '/afspraakhistorie.tpl'; ?>
        </aside>

    </div>
</div>

<?php include __DIR__ . '/invoice-modal.tpl'; ?>
<?php include __DIR__ . '/appointment-modal.tpl'; ?>

<script>
/**
 * Hard-fix for mobile behavior:
 * - Make sure the viewport meta is present and correct
 * - Force a resize so CSS media queries are recalculated
 * This runs immediately when the script is parsed, and again on load/pageshow.
 */
(function () {
    function ensureViewport() {
        var head = document.head || document.getElementsByTagName('head')[0];
        if (!head) return;

        var meta = head.querySelector('meta[name="viewport"]');
        var content = 'width=device-width, initial-scale=1, viewport-fit=cover';

        if (!meta) {
            meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = content;
            head.appendChild(meta);
        } else {
            meta.setAttribute('content', content);
        }
    }

    function forceMediaQueryRecalc() {
        try {
            // simplest: standard resize event
            window.dispatchEvent(new Event('resize'));
        } catch (e) {
            // older browsers fallback
            var ev = document.createEvent('UIEvents');
            ev.initUIEvent('resize', true, false, window, 0);
            window.dispatchEvent(ev);
        }
    }

    function applyMobileFix() {
        ensureViewport();
        // small timeout so the browser can register the new viewport
        setTimeout(forceMediaQueryRecalc, 0);
    }

    // run immediately when this script executes
    applyMobileFix();

    // be extra safe: also on load & pageshow (e.g. when navigating between tabs)
    window.addEventListener('load', applyMobileFix);
    window.addEventListener('pageshow', applyMobileFix);

    // debug: comment out if you don't want console noise
    console.log('[CP] viewport width now:', window.innerWidth);
})();
</script>

<script src="/Clientportal-logicare/cp-v2-scripts.js"></script>
