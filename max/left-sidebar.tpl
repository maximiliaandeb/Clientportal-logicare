<aside class="cp-v2-left">
    <div class="cp-v2-card">
        <div class="cp-v2-card-header">
            <div class="cp-v2-card-title-group">
                <img src="../media/profilepicture.png" alt="Praktijk logo" class="cp-v2-avatar" />
                <div>
                    <div class="cp-v2-section-title">
                        <?= htmlspecialchars($client['praktijk_naam']) ?>
                    </div>
                    <div style="font-size:12px;color:#6b7280;">
                        <?= htmlspecialchars($client['praktijk_url']) ?>
                    </div>
                </div>
            </div>
            <img src="../icons/dots-three-vertical-bold.svg" alt="Meer opties" class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--muted" />
        </div>

        <div style="display:flex;align-items:center;gap:6px;margin-top:8px;margin-bottom:4px;font-size:13px;font-weight:600;color:#111827;">
            <img src="../icons/user-circle-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
            <span>Mijn gegevens</span>
        </div>

        <dl class="cp-v2-detail-list">
            <dt>Naam:</dt>
            <dd><?= htmlspecialchars($client['naam']) ?></dd>

            <dt>Adresgegevens:</dt>
            <dd><?= nl2br(htmlspecialchars($client['adres'])) ?></dd>

            <dt>Plaats:</dt>
            <dd><?= htmlspecialchars($client['plaats']) ?></dd>

            <dt>Telefoonnummer:</dt>
            <dd><?= htmlspecialchars($client['telefoon']) ?></dd>

            <dt>Mobiele nummer:</dt>
            <dd><?= htmlspecialchars($client['mobiel']) ?></dd>

            <dt>Email:</dt>
            <dd><?= htmlspecialchars($client['email']) ?></dd>
        </dl>
    </div>

    <nav class="cp-v2-side-menu">
        <a href="?section=overzicht" class="<?= $section=='overzicht'?'cp-active':'' ?>">
            <img src="../icons/gear-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
            Wijzig profiel
        </a>
        <a href="?section=overzicht">
            <img src="../icons/key-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
            Wijzig wachtwoord
        </a>
        <a href="?section=documenten" class="<?= $section=='documenten' || $section=='documenten_upload' ? 'cp-active' : '' ?>">
            <img src="../icons/download-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
            Downloads / Documenten
        </a>
        <a href="?section=overzicht">
            <img src="../icons/phone-call-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
            Bel me terug
        </a>
        <a href="?section=overzicht">
            <img src="../icons/info-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
            Stel een vraag
        </a>
    </nav>
</aside>