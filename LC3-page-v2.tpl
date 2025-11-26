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
    array('date' => '20/11/2025', 'type' => 'Beeldbellen',  'time' => '13:00–13:30'),
    array('date' => '15/11/2025', 'type' => 'Behandeling',  'time' => '13:00–13:30'),
    array('date' => 'Morgen',     'type' => 'Intake',       'time' => '14:00–14:45'),
);

// Dummy vragenlijsten (sidebar)
$allQuestionnaires = array(
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'todo'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'todo'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'voldaan'),
);

// Voor de "Te doen" tabel in het midden (blijft gewoon To Do)
$todoQuestionnaires = array_filter($allQuestionnaires, function ($q) {
    return $q['status'] === 'todo';
});

// Welke vragenlijst-tab is actief in de sidebar?
$questionnaireTab = isset($_GET['qtab']) ? $_GET['qtab'] : 'alle';
$validQuestionnaireTabs = array('alle', 'todo', 'voldaan');
if (!in_array($questionnaireTab, $validQuestionnaireTabs)) {
    $questionnaireTab = 'alle';
}

// Filter lijsten op basis van tab (alle / todo / voldaan)
$filteredQuestionnaires = array_filter($allQuestionnaires, function ($q) use ($questionnaireTab) {
    if ($questionnaireTab === 'todo') {
        return $q['status'] === 'todo';
    }
    if ($questionnaireTab === 'voldaan') {
        return $q['status'] === 'voldaan';
    }
    return true; // 'alle'
});


/**
 * FACTUREN DATA
 * - 13: betaald (due 0)
 * - 14: openstaand (due 360)
 * - 15: betaald (due 0)
 */
$openInvoices = array(
    array('nr' => 13, 'date' => '21/09/2025', 'total' => '2500.00', 'due' => '0.00'),
    array('nr' => 14, 'date' => '21/09/2025', 'total' => '360.00',  'due' => '360.00'),
    array('nr' => 15, 'date' => '21/09/2025', 'total' => '1400.00', 'due' => '0.00'),
);

// Alleen facturen die nog iets open hebben (voor de "Te doen" tabel in het midden)
$todoInvoices = array_filter($openInvoices, function ($inv) {
    $due = isset($inv['due']) ? (float) str_replace(',', '.', $inv['due']) : 0;
    return $due > 0.0001;
});


// Welke facturen-tab is actief in de sidebar?
$invoiceTab = isset($_GET['ftab']) ? $_GET['ftab'] : 'alle';
$validInvoiceTabs = array('alle', 'openstaand', 'voldaan');
if (!in_array($invoiceTab, $validInvoiceTabs)) {
    $invoiceTab = 'alle';
}

// Filter facturen op basis van tab (alle / openstaand / voldaan)
$filteredInvoices = array_filter($openInvoices, function ($inv) use ($invoiceTab) {
    $due = isset($inv['due']) ? (float) str_replace(',', '.', $inv['due']) : 0;

    if ($invoiceTab === 'openstaand') {
        return $due > 0.0001;
    }
    if ($invoiceTab === 'voldaan') {
        return $due <= 0.0001;
    }
    // 'alle'
    return true;
});

$historyAppointments = array(
    array('label' => 'Gister', 'items' => array(
        array('date' => 'Gister',     'time' => '10:00–12:00', 'type' => 'Beeldbellen'),
    )),
    array('label' => '21/09/2025', 'items' => array(
        array('date' => '21/09/2025', 'time' => '14:00–15:00', 'type' => 'Intakegesprek'),
    )),
    array('label' => '21/09/2025', 'items' => array(
        array('date' => '21/09/2025', 'time' => '14:00–15:00', 'type' => 'Intakegesprek'),
    )),
    array('label' => '21/09/2025', 'items' => array(
        array('date' => 'Gister',     'time' => '10:00–12:00', 'type' => 'Beeldbellen'),
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
        return 'icons/calendar-dots-thin.svg';
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
                            <?php foreach ($todoInvoices as $inv): ?>
                                <tr>
                                    <td><?= (int)$inv['nr'] ?></td>
                                    <td><?= htmlspecialchars($inv['date']) ?></td>
                                    <td><?= htmlspecialchars($inv['total']) ?></td>
                                    <td><?= htmlspecialchars($inv['due']) ?></td>
                                    <td>
                                        <div class="cp-v2-row-actions">
                                            <a href="#"
                                            class="cp-v2-chip-button cp-v2-chip-button--alert js-open-invoice-modal"
                                            data-invoice-nr="<?= (int)$inv['nr'] ?>"
                                            data-invoice-date="<?= htmlspecialchars($inv['date']) ?>"
                                            data-invoice-total="<?= htmlspecialchars($inv['total']) ?>"
                                            data-invoice-due="<?= htmlspecialchars($inv['due']) ?>"
                                            >
                                                <span class="cp-v2-chip-badge"></span>
                                                <img src="icons/credit-card-thin.svg"
                                                    alt=""
                                                    class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--primary" />
                                                Factuur betalen
                                            </a>

                                            <button class="cp-v2-dot-menu" type="button">
                                                <img src="icons/dots-three-vertical-bold.svg"
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
                                <img src="icons/check-bold.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
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

    <?php $qBaseUrl = '?section=' . urlencode($section); ?>

    <div class="cp-v2-subtabs">
        <a href="<?= $qBaseUrl ?>&qtab=alle"
           class="cp-v2-subtab <?= $questionnaireTab === 'alle' ? 'cp-v2-subtab--active' : '' ?>">
            Alle
        </a>
        <a href="<?= $qBaseUrl ?>&qtab=todo"
           class="cp-v2-subtab <?= $questionnaireTab === 'todo' ? 'cp-v2-subtab--active' : '' ?>">
            Te doen
        </a>
        <a href="<?= $qBaseUrl ?>&qtab=voldaan"
           class="cp-v2-subtab <?= $questionnaireTab === 'voldaan' ? 'cp-v2-subtab--active' : '' ?>">
            Voldaan
        </a>
    </div>

    <?php if (empty($filteredQuestionnaires)): ?>
        <p style="font-size:12px;color:#6b7280;margin-top:6px;">
            Er zijn geen vragenlijsten in deze categorie.
        </p>
    <?php else: ?>
        <div class="cp-v2-questionnaire-list">
            <?php foreach ($filteredQuestionnaires as $q): ?>
                <div class="cp-v2-questionnaire-row">
                    <div class="cp-v2-questionnaire-main">
                        <div class="cp-v2-questionnaire-title">
                            <?= htmlspecialchars($q['titel']) ?>
                        </div>
                        <div class="cp-v2-questionnaire-date">
                            <?= htmlspecialchars($q['datum']) ?>
                        </div>
                    </div>

                    <?php if ($q['status'] === 'voldaan'): ?>
                        <!-- Groen check-icoon -->
                        <span class="cp-v2-status-pill cp-v2-status-pill--ok">
                            <img src="icons/check-bold.svg"
                                 alt=""
                                 class="cp-v2-icon cp-v2-icon--status" />
                        </span>
                    <?php else: ?>
                        <!-- Clock + rood bolletje voor 'Te doen' -->
                        <span class="cp-v2-status-pill cp-v2-status-pill--alert">
                            <span class="cp-v2-status-pill-badge"></span>
                            <img src="icons/clock-countdown-thin.svg"
                                 alt=""
                                 class="cp-v2-icon cp-v2-icon--status" />
                        </span>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>


            <div class="cp-v2-card cp-v2-right-section">
    <div class="cp-v2-section-title">Facturen</div>

    <?php $baseUrl = '?section=' . urlencode($section); ?>

    <div class="cp-v2-subtabs">
        <a href="<?= $baseUrl ?>&ftab=alle"
           class="cp-v2-subtab <?= $invoiceTab === 'alle' ? 'cp-v2-subtab--active' : '' ?>">
            Alle
        </a>
        <a href="<?= $baseUrl ?>&ftab=openstaand"
           class="cp-v2-subtab <?= $invoiceTab === 'openstaand' ? 'cp-v2-subtab--active' : '' ?>">
            Openstaand
        </a>
        <a href="<?= $baseUrl ?>&ftab=voldaan"
           class="cp-v2-subtab <?= $invoiceTab === 'voldaan' ? 'cp-v2-subtab--active' : '' ?>">
            Voldaan
        </a>
    </div>

    <?php if (empty($filteredInvoices)): ?>
        <p style="font-size:12px;color:#6b7280;margin-top:6px;">
            Er zijn geen facturen in deze categorie.
        </p>
    <?php else: ?>
        <div class="cp-v2-invoice-list">
            <?php foreach ($filteredInvoices as $inv): ?>
                <?php $due = (float) str_replace(',', '.', $inv['due']); ?>
                <div class="cp-v2-invoice-row"
                    data-invoice-nr="<?= (int) $inv['nr'] ?>"
                    data-invoice-date="<?= htmlspecialchars($inv['date']) ?>"
                    data-invoice-total="<?= htmlspecialchars($inv['total']) ?>"
                    data-invoice-due="<?= htmlspecialchars($inv['due']) ?>">

                    <div class="cp-v2-invoice-main">
                        <a href="#"
                        class="cp-v2-invoice-number">
                            <?= (int) $inv['nr'] ?>
                        </a>
                        <div class="cp-v2-invoice-date">
                            <?= htmlspecialchars($inv['date']) ?>
                        </div>
                    </div>

                    <div class="cp-v2-invoice-amounts">
                        <div class="cp-v2-invoice-amount-block">
                            <div class="cp-v2-invoice-label">Totaal</div>
                            <div class="cp-v2-invoice-value">
                                €<?= htmlspecialchars($inv['total']) ?>
                            </div>
                        </div>
                        <div class="cp-v2-invoice-amount-block">
                            <div class="cp-v2-invoice-label">Te betalen</div>
                            <div class="cp-v2-invoice-value">
                                €<?= htmlspecialchars($inv['due']) ?>
                            </div>
                        </div>
                    </div>

                    <div class="cp-v2-invoice-status">
                        <?php if ($due > 0.0001): ?>
                            <!-- openstaand: creditcard + rood bolletje -->
                            <button type="button"
                                    class="cp-v2-status-pill cp-v2-status-pill--alert cp-v2-invoice-open">
                                <span class="cp-v2-status-pill-badge"></span>
                                <img src="icons/credit-card-thin.svg"
                                    alt=""
                                    class="cp-v2-icon cp-v2-icon--status" />
                            </button>
                        <?php else: ?>
                            <!-- voldaan: groene check -->
                            <button type="button"
                                    class="cp-v2-status-pill cp-v2-status-pill--ok cp-v2-invoice-open">
                                <img src="icons/check-bold.svg"
                                    alt=""
                                    class="cp-v2-icon cp-v2-icon--status" />
                            </button>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endforeach; ?>

        </div>
    <?php endif; ?>
</div>



            <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Afspraakshistorie</div>

                <div class="cp-v2-timeline">
                    <?php foreach ($historyAppointments as $group): ?>
                        <div class="cp-v2-timeline-row">
                            <div class="cp-v2-timeline-axis">
                                <div class="cp-v2-timeline-dot"></div>
                            </div>

                            <div class="cp-v2-timeline-content">
                                <div class="cp-v2-timeline-label">
                                    <?= htmlspecialchars($group['label']) ?>
                                </div>

                                <?php foreach ($group['items'] as $item): ?>
                                    <div class="cp-v2-timeline-item">
                                        <div class="cp-v2-timeline-item-icon">
                                            <img src="<?= cp_v2_appointment_icon($item['type']) ?>"
                                                alt=""
                                                class="cp-v2-icon cp-v2-icon--tiny" />
                                        </div>
                                        <div class="cp-v2-timeline-item-text">
                                            <span class="cp-v2-timeline-time">
                                                <?= htmlspecialchars($item['time']) ?>
                                            </span>
                                            <span class="cp-v2-timeline-type">
                                                <?= htmlspecialchars($item['type']) ?>
                                            </span>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>


        </aside>

    </div>
</div>

<!-- Modal overlay + reusable invoice modal -->
<div class="cp-v2-modal-overlay"></div>

<div class="cp-v2-modal" id="cp-v2-invoice-modal">
    <div class="cp-v2-modal-inner">

        <div class="cp-v2-modal-header">
            <div>
                <h2 class="cp-v2-modal-title">Factuur</h2>
                <div class="cp-v2-modal-meta">
                    Factuurnummer <span id="cp-invoice-number"></span>
                </div>
            </div>
            <button type="button"
                    class="cp-v2-modal-close"
                    data-modal-close>
                ×
            </button>
        </div>

        <div class="cp-v2-modal-body">
            <!-- top: praktijk + metadata -->
            <div class="cp-v2-invoice-top">
                <div class="cp-v2-invoice-title-block">
                    <h3><?= htmlspecialchars($client['praktijk_naam']) ?></h3>
                    <p>
                        <?= htmlspecialchars($client['praktijk_url']) ?><br>
                        <?= nl2br(htmlspecialchars($client['adres'])) ?><br>
                        <?= htmlspecialchars($client['plaats']) ?>
                    </p>
                </div>

                <div class="cp-v2-invoice-meta">
                    <dl>
                        <dt>Factuurdatum</dt>
                        <dd id="cp-invoice-date"></dd>

                        <dt>Vervaldatum</dt>
                        <dd id="cp-invoice-due-date">
                            <!-- placeholder; kun je later echt uitrekenen -->
                            14 dagen na factuurdatum
                        </dd>
                    </dl>
                </div>
            </div>

            <!-- billed to -->
            <div class="cp-v2-invoice-billto">
                <div class="cp-v2-invoice-billto-label">Gefactureerd aan</div>
                <div class="cp-v2-invoice-billto-name">
                    <?= htmlspecialchars($client['naam']) ?>
                </div>
                <div class="cp-v2-invoice-billto-text">
                    <!-- hier zou je later cliënt-adres kunnen tonen -->
                    Cliëntnummer: 123456<br>
                    E-mail: <?= htmlspecialchars($client['email']) ?>
                </div>
            </div>

            <!-- lines -->
            <table class="cp-v2-invoice-lines">
                <thead>
                    <tr>
                        <th>Omschrijving</th>
                        <th>Aantal</th>
                        <th>Tarief</th>
                        <th>Totaal</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td id="cp-invoice-line-desc">
                            Behandeling / traject
                        </td>
                        <td>1</td>
                        <td id="cp-invoice-line-rate">€0.00</td>
                        <td id="cp-invoice-line-total">€0.00</td>
                    </tr>
                </tbody>
            </table>

            <!-- totals -->
            <div class="cp-v2-invoice-totals">
                <div class="cp-v2-invoice-totals-inner">
                    <div class="cp-v2-invoice-totals-row">
                        <div class="cp-v2-invoice-totals-label">Subtotaal</div>
                        <div class="cp-v2-invoice-totals-value" id="cp-invoice-subtotal">
                            €0.00
                        </div>
                    </div>
                    <div class="cp-v2-invoice-totals-row" id="cp-invoice-due-row">
                        <div class="cp-v2-invoice-totals-label">Nog te betalen</div>
                        <div class="cp-v2-invoice-totals-value" id="cp-invoice-due">
                            €0.00
                        </div>
                    </div>
                    <div class="cp-v2-invoice-totals-row is-total">
                        <div class="cp-v2-invoice-totals-label">Totaal</div>
                        <div class="cp-v2-invoice-totals-value" id="cp-invoice-total">
                            €0.00
                        </div>
                    </div>
                </div>
            </div>

            <!-- footer info -->
            <div class="cp-v2-invoice-footer">
                <div class="cp-v2-invoice-footer-block">
                    <div class="cp-v2-invoice-footer-title">
                        Praktijkgegevens
                    </div>
                    <p>
                        <?= htmlspecialchars($client['praktijk_naam']) ?><br>
                        <?= htmlspecialchars($client['telefoon']) ?><br>
                        <?= htmlspecialchars($client['email']) ?>
                    </p>
                </div>
                <div class="cp-v2-invoice-footer-block">
                    <div class="cp-v2-invoice-footer-title">
                        Betaalinstructies
                    </div>
                    <p>
                        IBAN: NL00BANK0123456789<br>
                        Betaal binnen 14 dagen o.v.v.
                        factuurnummer.
                    </p>
                </div>
            </div>
        </div>

        <div class="cp-v2-modal-footer">
            <button type="button"
                    class="cp-v2-button-secondary"
                    id="cp-invoice-print-btn">
                Printen
            </button>
            <button type="button"
                    class="cp-v2-button-secondary"
                    data-modal-close>
                Annuleren
            </button>
            <button type="button"
                    class="cp-v2-button-primary"
                    id="cp-invoice-pay-btn">
                Betaal nu
            </button>
        </div>
    </div>
</div>


<script src="cp-v2-scripts.js"></script>
