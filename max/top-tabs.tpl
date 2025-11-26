<nav class="cp-v2-tabs">
    <div class="cp-v2-tabs-left">
        <a href="?section=overzicht"
           class="cp-v2-tab <?= $section=='overzicht'?'cp-v2-tab--active':'' ?>">
            <img src="../icons/house-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
            Overzicht
        </a>
        <a href="?section=statistiek"
           class="cp-v2-tab <?= $section=='statistiek'?'cp-v2-tab--active':'' ?>">
            <img src="../icons/gauge-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
            Statistiek
        </a>
        <a href="?section=documenten"
           class="cp-v2-tab <?= ($section=='documenten' || $section=='documenten_upload')?'cp-v2-tab--active':'' ?>">
            <img src="../icons/file-text-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
            Documenten
        </a>
        <a href="?section=dossier"
           class="cp-v2-tab <?= $section=='dossier'?'cp-v2-tab--active':'' ?>">
            <img src="../icons/archive-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
            Dossier
        </a>
    </div>

    <div class="cp-v2-tabs-right">
        <button class="cp-v2-main-bell"
                type="button"
                id="cp-main-notify-btn"
                aria-haspopup="true"
                aria-expanded="false">
            <span class="cp-v2-main-bell-inner">
                <img src="../icons/bell-thin.svg"
                    alt="Meldingen"
                    class="cp-v2-main-bell-icon" />
                <?php if ($hasNotifications): ?>
                    <span class="cp-v2-notify-dot"></span>
                <?php endif; ?>
            </span>
        </button>

        <div class="cp-v2-notify-dropdown" id="cp-main-notify-dropdown">
            <div class="cp-v2-notify-header">Meldingen</div>

            <?php if (empty($notifications)): ?>
                <div class="cp-v2-notify-empty">
                    Je hebt geen nieuwe meldingen.
                </div>
            <?php else: ?>
                <ul class="cp-v2-notify-list">
                    <?php foreach ($notifications as $n): ?>
                        <li class="cp-v2-notify-item cp-v2-notify-item--<?= htmlspecialchars($n['type']) ?>">
                            <div class="cp-v2-notify-item-icon">
                                <img src="<?= htmlspecialchars($n['icon']) ?>"
                                    alt=""
                                    class="cp-v2-icon cp-v2-icon--tiny" />
                            </div>
                            <div class="cp-v2-notify-item-text">
                                <div class="cp-v2-notify-title">
                                    <?= htmlspecialchars($n['title']) ?>
                                </div>
                                <div class="cp-v2-notify-meta">
                                    <?= htmlspecialchars($n['meta']) ?>
                                </div>
                            </div>
                        </li>
                    <?php endforeach; ?>
                </ul>
            <?php endif; ?>
        </div>
    </div>
</nav>