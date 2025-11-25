<?
// Bepaal welke "tab" actief is
$section = isset($_GET['section']) ? $_GET['section'] : 'overzicht';
$validSections = array('overzicht', 'statistiek', 'documenten', 'dossier');
if (!in_array($section, $validSections)) {
    $section = 'overzicht';
}

// Dummy data – later vervangen door echte data uit het systeem
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
    array('date' => '20/11/2025', 'type' => 'Beeldbellen', 'time' => '13:00–13:30', 'icon' => '📹'),
    array('date' => '15/11/2025', 'type' => 'Behandeling', 'time' => '13:00–13:30', 'icon' => '📅'),
    array('date' => 'Morgen',      'type' => 'Intake',      'time' => '14:00–14:45', 'icon' => '🗣️'),
);

$todoQuestionnaires = array(
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'Te doen'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'Te doen'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'Te doen'),
);

$openInvoices = array(
    array('nr' => 13, 'date' => '21/09/2025', 'total' => '360.00', 'due' => '360.00'),
    array('nr' => 13, 'date' => '21/09/2025', 'total' => '360.00', 'due' => '360.00'),
    array('nr' => 13, 'date' => '21/09/2025', 'total' => '360.00', 'due' => '360.00'),
);

$historyAppointments = array(
    array('label' => 'Gister', 'items' => array(
        array('date' => 'Gister',      'time' => '10:00–12:00', 'type' => 'Beeldbellen'),
    )),
    array('label' => '21/09/2025', 'items' => array(
        array('date' => '21/09/2025',  'time' => '14:00–15:00', 'type' => 'Intakegesprek'),
    )),
);
?>

<style>
    /* Heel basic layout-styles – later vervang je dit door echte CSS */
    .cp-v2-root {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif;
        background: #f5f7fb;
        padding: 20px;
        box-sizing: border-box;
    }
    .cp-v2-layout {
        display: grid;
        grid-template-columns: 260px minmax(0, 1fr) 320px;
        gap: 16px;
        align-items: flex-start;
    }
    .cp-v2-card {
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
        padding: 16px 20px;
        box-sizing: border-box;
    }
    .cp-v2-left,
    .cp-v2-main,
    .cp-v2-right {
        min-height: 100px;
    }
    .cp-v2-tabs {
        display: flex;
        gap: 12px;
        margin-bottom: 16px;
        border-bottom: 1px solid #dde1ea;
    }
    .cp-v2-tab {
        padding: 10px 16px;
        border-radius: 6px 6px 0 0;
        text-decoration: none;
        color: #4b5563;
        font-size: 14px;
    }
    .cp-v2-tab--active {
        background: #e5f3ff;
        color: #1f2937;
        font-weight: 600;
        border-bottom: 2px solid #2f7abf;
    }
    .cp-v2-page-title {
        font-size: 24px;
        margin: 0 0 16px;
        color: #111827;
        font-weight: 600;
    }
    .cp-v2-section-title {
        font-size: 16px;
        font-weight: 600;
        margin: 0 0 8px;
        color: #111827;
    }
    .cp-v2-small-title {
        font-size: 14px;
        font-weight: 600;
        margin: 16px 0 8px;
        color: #111827;
    }
    .cp-v2-detail-list {
        font-size: 13px;
        margin: 8px 0 0;
    }
    .cp-v2-detail-list dt {
        font-weight: 600;
    }
    .cp-v2-detail-list dd {
        margin: 0 0 4px;
    }
    .cp-v2-side-menu {
        margin-top: 24px;
        font-size: 14px;
    }
    .cp-v2-side-menu a {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 10px;
        border-radius: 6px;
        text-decoration: none;
        color: #374151;
        margin-bottom: 4px;
    }
    .cp-v2-side-menu a.cp-active {
        background: #e5f3ff;
        color: #1f2937;
        font-weight: 600;
    }
    .cp-v2-button-primary {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 14px;
        border-radius: 6px;
        background: #2f7abf;
        color: #ffffff;
        text-decoration: none;
        font-size: 13px;
    }
    .cp-v2-appointments-row {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 12px;
        margin-top: 8px;
    }
    .cp-v2-appointment-tile {
        background: #f8fafc;
        border-radius: 8px;
        padding: 10px 12px;
        font-size: 13px;
        border: 1px solid #e5e7eb;
    }
    .cp-v2-appointment-date {
        font-weight: 600;
        margin-bottom: 2px;
    }
    .cp-v2-appointment-type {
        color: #111827;
    }
    .cp-v2-appointment-time {
        color: #4b5563;
        font-size: 12px;
    }
    .cp-v2-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 8px;
        font-size: 13px;
    }
    .cp-v2-table th,
    .cp-v2-table td {
        padding: 6px 8px;
        border-bottom: 1px solid #e5e7eb;
        text-align: left;
    }
    .cp-v2-chip-button {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 4px 10px;
        border-radius: 999px;
        background: #f1f5f9;
        font-size: 11px;
        text-decoration: none;
        color: #1f2937;
    }
    .cp-v2-chip-button--accent {
        background: #f97373;
        color: #ffffff;
    }
    .cp-v2-right-section {
        margin-bottom: 16px;
    }
    .cp-v2-timeline {
        font-size: 12px;
    }
    .cp-v2-timeline-label {
        font-weight: 600;
        margin-top: 8px;
        margin-bottom: 4px;
    }
    .cp-v2-timeline-item {
        margin-left: 8px;
        margin-bottom: 4px;
    }
</style>

<div class="cp-v2-root">

    <div class="cp-v2-layout">

        <!-- =========================
             LINKER SIDEBAR
             ========================= -->
        <aside class="cp-v2-left">
            <div class="cp-v2-card">
                <div class="cp-v2-section-title">
                    <?= htmlspecialchars($client['praktijk_naam']) ?>
                </div>
                <div style="font-size:12px;color:#6b7280;">
                    <?= htmlspecialchars($client['praktijk_url']) ?>
                </div>

                <div class="cp-v2-small-title" style="margin-top:16px;">Mijn gegevens</div>
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
                <a href="?cp_v2=1&section=overzicht" class="<?= $section=='overzicht'?'cp-active':'' ?>">
                    Wijzig profiel
                </a>
                <a href="?cp_v2=1&section=overzicht">
                    Wijzig wachtwoord
                </a>
                <a href="?cp_v2=1&section=documenten" class="<?= $section=='documenten'?'cp-active':'' ?>">
                    Downloads / Documenten
                </a>
                <a href="?cp_v2=1&section=overzicht">
                    Bel me terug
                </a>
                <a href="?cp_v2=1&section=overzicht">
                    Stel een vraag
                </a>
            </nav>
        </aside>

        <!-- =========================
             MIDDENKOLOM
             ========================= -->
        <main class="cp-v2-main">
            <!-- Top tabs -->
            <nav class="cp-v2-tabs">
                <a href="?cp_v2=1&section=overzicht"
                   class="cp-v2-tab <?= $section=='overzicht'?'cp-v2-tab--active':'' ?>">
                    Overzicht
                </a>
                <a href="?cp_v2=1&section=statistiek"
                   class="cp-v2-tab <?= $section=='statistiek'?'cp-v2-tab--active':'' ?>">
                    Statistiek
                </a>
                <a href="?cp_v2=1&section=documenten"
                   class="cp-v2-tab <?= $section=='documenten'?'cp-v2-tab--active':'' ?>">
                    Documenten
                </a>
                <a href="?cp_v2=1&section=dossier"
                   class="cp-v2-tab <?= $section=='dossier'?'cp-v2-tab--active':'' ?>">
                    Dossier
                </a>
            </nav>

            <div class="cp-v2-card">
                <h1 class="cp-v2-page-title">
                    Welkom <?= htmlspecialchars($client['naam']) ?>
                </h1>

                <? if ($section == 'overzicht'): ?>

                    <!-- KOMENDE AFSPRAKEN -->
                    <div>
                        <div class="cp-v2-section-title">Komende afspraken</div>
                        <a href="#"
                           class="cp-v2-button-primary"
                           style="margin-top:4px;margin-bottom:8px;">
                            + Maak een nieuwe afspraak
                        </a>
                        <div class="cp-v2-appointments-row">
                            <? foreach ($upcomingAppointments as $afs): ?>
                                <article class="cp-v2-appointment-tile">
                                    <div class="cp-v2-appointment-date">
                                        <?= htmlspecialchars($afs['date']) ?>
                                    </div>
                                    <div class="cp-v2-appointment-type">
                                        <?= htmlspecialchars($afs['type']) ?>
                                    </div>
                                    <div class="cp-v2-appointment-time">
                                        <?= htmlspecialchars($afs['time']) ?>
                                    </div>
                                </article>
                            <? endforeach; ?>
                        </div>
                    </div>

                    <!-- TE DOEN -->
                    <div style="margin-top:24px;">
                        <div class="cp-v2-section-title">Te doen</div>

                        <div class="cp-v2-small-title">Vragenlijsten</div>
                        <table class="cp-v2-table">
                            <thead>
                            <tr>
                                <th>Onderwerp</th>
                                <th>Datum</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <? foreach ($todoQuestionnaires as $q): ?>
                                <tr>
                                    <td><?= htmlspecialchars($q['titel']) ?></td>
                                    <td><?= htmlspecialchars($q['datum']) ?></td>
                                    <td>
                                        <a href="#" class="cp-v2-chip-button">
                                            Vragenlijst openen
                                        </a>
                                    </td>
                                </tr>
                            <? endforeach; ?>
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
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <? foreach ($openInvoices as $inv): ?>
                                <tr>
                                    <td><?= (int)$inv['nr'] ?></td>
                                    <td><?= htmlspecialchars($inv['date']) ?></td>
                                    <td><?= htmlspecialchars($inv['total']) ?></td>
                                    <td><?= htmlspecialchars($inv['due']) ?></td>
                                    <td>
                                        <a href="#" class="cp-v2-chip-button cp-v2-chip-button--accent">
                                            Factuur betalen
                                        </a>
                                    </td>
                                </tr>
                            <? endforeach; ?>
                            </tbody>
                        </table>
                    </div>

                <? elseif ($section == 'statistiek'): ?>

                    <!-- Placeholder voor STATISTIEK -->
                    <div>
                        <div class="cp-v2-section-title">Mijn behandeltraject</div>
                        <p style="font-size:13px;color:#6b7280;">
                            Hier komen je grafieken en statistieken (pie charts, bar charts, etc.).
                            Voor nu is dit een placeholder zodat de layout klopt.
                        </p>
                    </div>

                <? elseif ($section == 'documenten'): ?>

                    <!-- DOCUMENTEN OVERZICHT -->
                    <div>
                        <div class="cp-v2-section-title">Mijn documenten</div>
                        <a href="?cp_v2=1&section=documenten_upload"
                           class="cp-v2-button-primary"
                           style="margin-top:4px;margin-bottom:8px;">
                            + Upload een document
                        </a>

                        <table class="cp-v2-table">
                            <thead>
                            <tr>
                                <th>Naam document</th>
                                <th>Actiedatum</th>
                                <th>Omschrijving</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Document 1</td>
                                <td>20/09/2024</td>
                                <td>Lorem ipsum</td>
                                <td>
                                    <a href="#" class="cp-v2-chip-button">Download</a>
                                </td>
                            </tr>
                            <tr>
                                <td>Document 2</td>
                                <td>20/09/2024</td>
                                <td>Lorem ipsum</td>
                                <td>
                                    <a href="#" class="cp-v2-chip-button">Download</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                <? elseif ($section == 'documenten_upload'): ?>

                    <!-- DOCUMENT UPLOAD -->
                    <div>
                        <div class="cp-v2-section-title">Upload een document</div>
                        <p style="font-size:13px;color:#6b7280;margin-bottom:12px;">
                            Hier komt later de echte uploadcomponent met drag & drop / voortgangsbalk.
                        </p>
                        <div class="cp-v2-card" style="border:2px dashed #d1d5db;text-align:center;">
                            Klik om een document te uploaden (placeholder)
                        </div>

                        <div style="margin-top:16px;display:flex;gap:8px;">
                            <a href="#" class="cp-v2-button-primary">Opslaan</a>
                            <a href="#" class="cp-v2-chip-button">Verwijderen</a>
                        </div>
                    </div>

                <? else: /* dossier */ ?>

                    <!-- DOSSIER PLACEHOLDER -->
                    <div>
                        <div class="cp-v2-section-title">Dossier</div>
                        <p style="font-size:13px;color:#6b7280;">
                            Hier komt later het dossier-overzicht / notities / verslagen.
                        </p>
                    </div>

                <? endif; ?>
            </div>
        </main>

        <!-- =========================
             RECHTER SIDEBAR
             ========================= -->
        <aside class="cp-v2-right">
            <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Vragenlijsten</div>
                <p style="font-size:12px;color:#6b7280;margin-bottom:4px;">
                    Tabs (Alle / Te doen / Voldaan) komen hier later.
                </p>
                <? foreach ($todoQuestionnaires as $q): ?>
                    <div style="font-size:12px;margin-bottom:6px;">
                        <strong><?= htmlspecialchars($q['titel']) ?></strong><br>
                        <span><?= htmlspecialchars($q['datum']) ?></span>
                    </div>
                <? endforeach; ?>
            </div>

            <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Facturen</div>
                <p style="font-size:12px;color:#6b7280;margin-bottom:4px;">
                    Tabs (Alle / Openstaand / Voldaan) komen hier later.
                </p>
                <? foreach ($openInvoices as $inv): ?>
                    <div style="font-size:12px;margin-bottom:6px;">
                        <a href="#" style="text-decoration:none;color:#2563eb;">
                            #<?= (int)$inv['nr'] ?>
                        </a>
                        &nbsp;– <?= htmlspecialchars($inv['date']) ?> – €<?= htmlspecialchars($inv['total']) ?>
                    </div>
                <? endforeach; ?>
            </div>

            <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Afspraakshistorie</div>
                <div class="cp-v2-timeline">
                    <? foreach ($historyAppointments as $group): ?>
                        <div class="cp-v2-timeline-label">
                            <?= htmlspecialchars($group['label']) ?>
                        </div>
                        <? foreach ($group['items'] as $item): ?>
                            <div class="cp-v2-timeline-item">
                                <?= htmlspecialchars($item['time']) ?> – <?= htmlspecialchars($item['type']) ?>
                            </div>
                        <? endforeach; ?>
                    <? endforeach; ?>
                </div>
            </div>
        </aside>

    </div>
</div>
