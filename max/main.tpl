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

<script src="/Clientportal-logicare/cp-v2-scripts.js"></script>
