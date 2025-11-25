<?php
// Welke tab is actief?
$section = isset($_GET['section']) ? $_GET['section'] : 'overzicht';
$validSections = array('overzicht', 'statistiek', 'documenten', 'documenten_upload', 'dossier');
if (!in_array($section, $validSections)) {
    $section = 'overzicht';
}

// Dummy client data
$client = array(
    'praktijk_naam' => 'Test Praktijk',
    'praktijk_url'  => 'www.testpraktijk.nl',
    'naam'          => 'Yamal Elshot',
    'adres'         => "Una Corda 39\nKrimpen a/d IJssel",
    'plaats'        => 'Krimpen a/d IJssel',
    'telefoon'      => '+31642032652',
    'mobiel'        => '+31642032652',
    'email'         => 'Yamal.elshot@hotmail.com',
);

// Dummy afspraken / vragenlijsten / facturen
$upcomingAppointments = array(
    array('date' => '20/11/2025', 'type' => 'Beeldbellen', 'time' => '13:00–13:30'),
    array('date' => '15/11/2025', 'type' => 'Behandeling', 'time' => '13:00–13:30'),
    array('date' => 'Morgen',      'type' => 'Intake',      'time' => '14:00–14:45'),
);

$todoQuestionnaires = array(
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'Te doen'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'Te doen'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'Te doen'),
);

$openInvoices = array(
    array('nr' => 13, 'date' => '21/09/2025', 'total' => '360.00', 'due' => '360.00'),
    array('nr' => 14, 'date' => '21/09/2025', 'total' => '360.00', 'due' => '360.00'),
    array('nr' => 15, 'date' => '21/09/2025', 'total' => '360.00', 'due' => '360.00'),
);

$historyAppointments = array(
    array('label' => 'Gister', 'items' => array(
        array('date' => 'Gister',     'time' => '10:00–12:00', 'type' => 'Beeldbellen'),
    )),
    array('label' => '21/09/2025', 'items' => array(
        array('date' => '21/09/2025', 'time' => '14:00–15:00', 'type' => 'Intakegesprek'),
    )),
);

// Kleine helper om een icoon bij een afspraaktype te kiezen
function cp_v2_appointment_icon($type) {
    $typeLower = mb_strtolower($type);
    if (strpos($typeLower, 'beeldbellen') !== false) {
        return 'icons/webcam-thin.svg';
    }
    if (strpos($typeLower, 'intake') !== false) {
        return 'icons/user-sound-thin.svg';
    }
    if (strpos($typeLower, 'behandeling') !== false) {
        return 'icons/calendar-dots-bold.svg';
    }
    return 'icons/info-thin.svg';
}
?>

<div class="cp-v2-root">
    <div class="cp-v2-layout">

        <!-- LEFT SIDEBAR -->
        <aside class="cp-v2-left">
            <div class="cp-v2-card">
                <div class="cp-v2-card-header">
                    <div class="cp-v2-card-title-group">
                        <img src="media/profilepicture.png" alt="Praktijk logo" class="cp-v2-avatar" />
                        <div>
                            <div class="cp-v2-section-title">
                                <?= htmlspecialchars($client['praktijk_naam']) ?>
                            </div>
                            <div style="font-size:12px;color:#6b7280;">
                                <?= htmlspecialchars($client['praktijk_url']) ?>
                            </div>
                        </div>
                    </div>
                    <img src="icons/dots-three-vertical-bold.svg" alt="Meer opties" class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--muted" />
                </div>

                <div style="display:flex;align-items:center;gap:6px;margin-top:8px;margin-bottom:4px;font-size:13px;font-weight:600;color:#111827;">
                    <img src="icons/user-circle-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
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
                    <img src="icons/gear-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                    Wijzig profiel
                </a>
                <a href="?section=overzicht">
                    <img src="icons/key-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                    Wijzig wachtwoord
                </a>
                <a href="?section=documenten" class="<?= $section=='documenten' || $section=='documenten_upload' ? 'cp-active' : '' ?>">
                    <img src="icons/download-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                    Downloads / Documenten
                </a>
                <a href="?section=overzicht">
                    <img src="icons/phone-call-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                    Bel me terug
                </a>
                <a href="?section=overzicht">
                    <img src="icons/info-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                    Stel een vraag
                </a>
            </nav>
        </aside>

        <!-- MAIN COLUMN -->
        <main class="cp-v2-main">
            <nav class="cp-v2-tabs">
                <a href="?section=overzicht" class="cp-v2-tab <?= $section=='overzicht'?'cp-v2-tab--active':'' ?>">
                    <img src="icons/house-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                    Overzicht
                </a>
                <a href="?section=statistiek" class="cp-v2-tab <?= $section=='statistiek'?'cp-v2-tab--active':'' ?>">
                    <img src="icons/gauge-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                    Statistiek
                </a>
                <a href="?section=documenten" class="cp-v2-tab <?= $section=='documenten' || $section=='documenten_upload'?'cp-v2-tab--active':'' ?>">
                    <img src="icons/file-text-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                    Documenten
                </a>
                <a href="?section=dossier" class="cp-v2-tab <?= $section=='dossier'?'cp-v2-tab--active':'' ?>">
                    <img src="icons/archive-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                    Dossier
                </a>
            </nav>

            <div class="cp-v2-card">
                <!-- notificatiebel -->
                <div class="cp-v2-main-bell">
                    <img src="icons/bell-thin.svg" alt="Meldingen" class="cp-v2-icon cp-v2-icon--tiny" />
                </div>

                <h1 class="cp-v2-page-title">
                    Welkom <?= htmlspecialchars($client['naam']) ?>
                </h1>

                <?php if ($section === 'overzicht'): ?>

                    <div>
                        <div class="cp-v2-section-title">Komende afspraken</div>
                        <a href="#" class="cp-v2-button-primary" style="margin-top:4px;margin-bottom:8px;">
                            <img src="icons/plus-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                            Maak een nieuwe afspraak
                        </a>
                        <div class="cp-v2-appointments-row">
                            <?php foreach ($upcomingAppointments as $afs): ?>
                                <article class="cp-v2-appointment-tile">
                                    <div class="cp-v2-appointment-date">
                                        <?= htmlspecialchars($afs['date']) ?>
                                    </div>
                                    <div class="cp-v2-appointment-type">
                                        <img src="<?= cp_v2_appointment_icon($afs['type']) ?>" alt="" class="cp-v2-icon cp-v2-icon--small" />
                                        <span><?= htmlspecialchars($afs['type']) ?></span>
                                    </div>
                                    <div class="cp-v2-appointment-time">
                                        <?= htmlspecialchars($afs['time']) ?>
                                    </div>
                                </article>
                            <?php endforeach; ?>
                        </div>
                    </div>

                    <div style="margin-top:24px;">
                        <div class="cp-v2-section-title">Te doen</div>

                        <div class="cp-v2-small-title">Vragenlijsten</div>
                        <table class="cp-v2-table">
                            <thead>
                            <tr>
                                <th>Onderwerp</th>
                                <th>Datum</th>
                                <th style="text-align:right;"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($todoQuestionnaires as $q): ?>
                                <tr>
                                    <td><?= htmlspecialchars($q['titel']) ?></td>
                                    <td><?= htmlspecialchars($q['datum']) ?></td>
                                    <td>
                                        <div class="cp-v2-row-actions">
                                            <span class="cp-v2-status-pill">
                                                <img src="icons/file-archive-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                                            </span>
                                            <a href="#" class="cp-v2-chip-button">
                                                <img src="icons/file-text-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                                                Vragenlijst openen
                                            </a>
                                            <button class="cp-v2-dot-menu" type="button">
                                                <img src="icons/dots-three-vertical-bold.svg" alt="Meer opties" class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--muted" />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                            </tbody>
                        </table>

                        <div class="cp-v2-small-title">Facturen</div>
                        <table class="cp-v2-table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Datum</th>
                                <th>Totaal</th>
                                <th>Te betalen</th>
                                <th style="text-align:right;"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($openInvoices as $inv): ?>
                                <tr>
                                    <td><?= (int)$inv['nr'] ?></td>
                                    <td><?= htmlspecialchars($inv['date']) ?></td>
                                    <td><?= htmlspecialchars($inv['total']) ?></td>
                                    <td><?= htmlspecialchars($inv['due']) ?></td>
                                    <td>
                                        <div class="cp-v2-row-actions">
                                            <a href="#" class="cp-v2-chip-button cp-v2-chip-button--alert">
                                                <span class="cp-v2-chip-badge"></span>
                                                <img src="icons/credit-card-thin.svg"
                                                    alt=""
                                                    class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--primary" />
                                                Factuur betalen
                                            </a>
                                            <button class="cp-v2-dot-menu" type="button">
                                                <img src="icons/dots-three-vertical-thin.svg"
                                                    alt="Meer opties"
                                                    class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--muted" />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>

                <?php elseif ($section === 'statistiek'): ?>

                    <div>
                        <div class="cp-v2-section-title">
                            <img src="icons/gauge-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                            &nbsp;Mijn behandeltraject
                        </div>
                        <p style="font-size:13px;color:#6b7280;">
                            Hier komen straks de grafieken en statistieken (pie charts, bar charts, etc.).
                        </p>
                    </div>

                <?php elseif ($section === 'documenten'): ?>

                    <div>
                        <div class="cp-v2-section-title">
                            <img src="icons/file-archive-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                            &nbsp;Mijn documenten
                        </div>
                        <a href="?section=documenten_upload" class="cp-v2-button-primary" style="margin-top:4px;margin-bottom:8px;">
                            <img src="icons/plus-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                            Upload een document
                        </a>

                        <table class="cp-v2-table">
                            <thead>
                            <tr>
                                <th>Naam document</th>
                                <th>Actiedatum</th>
                                <th>Omschrijving</th>
                                <th style="text-align:right;"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Document 1</td>
                                <td>20/09/2024</td>
                                <td>Lorem ipsum</td>
                                <td style="text-align:right;">
                                    <a href="#" class="cp-v2-chip-button">
                                        <img src="icons/download-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                                        Download
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>Document 2</td>
                                <td>20/09/2024</td>
                                <td>Lorem ipsum</td>
                                <td style="text-align:right;">
                                    <a href="#" class="cp-v2-chip-button">
                                        <img src="icons/download-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                                        Download
                                    </a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                <?php elseif ($section === 'documenten_upload'): ?>

                    <div>
                        <div class="cp-v2-section-title">
                            <img src="icons/file-arrow-up-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                            &nbsp;Upload een document
                        </div>
                        <p style="font-size:13px;color:#6b7280;margin-bottom:12px;">
                            Hier komt later de echte uploadcomponent met drag &amp; drop / voortgangsbalk.
                        </p>
                        <div class="cp-v2-card" style="border:2px dashed #d1d5db;text-align:center;">
                            <img src="icons/file-pdf-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                            &nbsp;Klik om een document te uploaden (placeholder)
                        </div>

                        <div style="margin-top:16px;display:flex;gap:8px;">
                            <a href="#" class="cp-v2-button-primary">
                                <img src="icons/check-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                                Opslaan
                            </a>
                            <a href="#" class="cp-v2-chip-button">
                                <img src="icons/trash-simple-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                                Verwijderen
                            </a>
                        </div>
                    </div>

                <?php else: /* dossier */ ?>

                    <div>
                        <div class="cp-v2-section-title">
                            <img src="icons/archive-fill.svg" alt="" class="cp-v2-icon cp-v2-icon--small" />
                            &nbsp;Dossier
                        </div>
                        <p style="font-size:13px;color:#6b7280;">
                            Hier komt later het dossier-overzicht / notities / verslagen.
                        </p>
                    </div>

                <?php endif; ?>
            </div>
        </main>

        <!-- RIGHT SIDEBAR -->
        <aside class="cp-v2-right">
            <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Vragenlijsten</div>
                <p style="font-size:12px;color:#6b7280;margin-bottom:4px;">
                    Tabs (Alle / Te doen / Voldaan) komen hier later.
                </p>
                <?php foreach ($todoQuestionnaires as $q): ?>
                    <div style="font-size:12px;margin-bottom:6px;display:flex;align-items:center;justify-content:space-between;gap:8px;">
                        <div>
                            <strong><?= htmlspecialchars($q['titel']) ?></strong><br>
                            <span><?= htmlspecialchars($q['datum']) ?></span>
                        </div>
                        <span class="cp-v2-status-pill">
                            <img src="icons/bell-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                        </span>
                    </div>
                <?php endforeach; ?>
            </div>

            <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Facturen</div>
                <p style="font-size:12px;color:#6b7280;margin-bottom:4px;">
                    Tabs (Alle / Openstaand / Voldaan) komen hier later.
                </p>
                <?php foreach ($openInvoices as $inv): ?>
                    <div style="font-size:12px;margin-bottom:6px;display:flex;align-items:center;justify-content:space-between;gap:8px;">
                        <div>
                            <a href="#" style="text-decoration:none;color:#2563eb;">
                                #<?= (int)$inv['nr'] ?>
                            </a>
                            &nbsp;– <?= htmlspecialchars($inv['date']) ?> – €<?= htmlspecialchars($inv['total']) ?>
                        </div>
                        <span class="cp-v2-status-pill">
                            <img src="icons/credit-card-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                        </span>
                    </div>
                <?php endforeach; ?>
            </div>

            <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Afspraakshistorie</div>
                <div class="cp-v2-timeline">
                    <?php foreach ($historyAppointments as $group): ?>
                        <div class="cp-v2-timeline-label">
                            <?= htmlspecialchars($group['label']) ?>
                        </div>
                        <?php foreach ($group['items'] as $item): ?>
                            <div class="cp-v2-timeline-item">
                                <img src="<?= cp_v2_appointment_icon($item['type']) ?>" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                                <div>
                                    <?= htmlspecialchars($item['time']) ?> – <?= htmlspecialchars($item['type']) ?>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php endforeach; ?>
                </div>
            </div>
        </aside>

    </div>
</div>
