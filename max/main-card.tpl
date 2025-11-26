<main class="cp-v2-main">
    <?php include 'top-tabs.tpl'; ?>

    <div class="cp-v2-card">
        <h1 class="cp-v2-page-title">
            Welkom <?= htmlspecialchars($client['naam']) ?>
        </h1>

        <?php if ($section === 'overzicht'): ?>
            <?php include 'overview.tpl'; ?>

        <?php elseif ($section === 'statistiek'): ?>
            <?php include 'statistiek.tpl'; ?>

        <?php elseif ($section === 'documenten'): ?>
            <?php include 'documenten.tpl'; ?>

        <?php elseif ($section === 'documenten_upload'): ?>
            <?php include 'documenten_upload.tpl'; ?>

        <?php else: /* dossier */ ?>
            <?php include 'dossier.tpl'; ?>

        <?php endif; ?>
    </div>
</main>