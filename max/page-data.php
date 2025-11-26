<?php
// page-data.php
// This central file defines the data used by the widgets in max/ (to avoid repeating logic in each include)

// Which tab is active?
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
    'birthdate'     => '01/06/1991',
    'adres'         => "Una Corda 39\nKrimpen a/d IJssel",
    'address_line1' => 'Una Corda 39',
    'address_line2' => 'Krimpen a/d IJssel',
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

/* VRAGENLIJSTEN */
$allQuestionnaires = array(
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'todo'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'todo'),
    array('titel' => 'Onderzoek', 'datum' => '20/09/2024', 'status' => 'voldaan'),
);

$todoQuestionnaires = array_filter($allQuestionnaires, function ($q) {
    return $q['status'] === 'todo';
});

$questionnaireTab = isset($_GET['qtab']) ? $_GET['qtab'] : 'alle';
$validQuestionnaireTabs = array('alle', 'todo', 'voldaan');
if (!in_array($questionnaireTab, $validQuestionnaireTabs)) {
    $questionnaireTab = 'alle';
}

$filteredQuestionnaires = array_filter($allQuestionnaires, function ($q) use ($questionnaireTab) {
    if ($questionnaireTab === 'todo') {
        return $q['status'] === 'todo';
    }
    if ($questionnaireTab === 'voldaan') {
        return $q['status'] === 'voldaan';
    }
    return true; // 'alle'
});

/* FACTUREN */
$openInvoices = array(
    array('nr' => 13, 'date' => '21/09/2025', 'total' => '2500.00', 'due' => '0.00'),
    array('nr' => 14, 'date' => '21/09/2025', 'total' => '360.00',  'due' => '360.00'),
    array('nr' => 15, 'date' => '21/09/2025', 'total' => '1400.00', 'due' => '0.00'),
);

$todoInvoices = array_filter($openInvoices, function ($inv) {
    $due = isset($inv['due']) ? (float) str_replace(',', '.', $inv['due']) : 0;
    return $due > 0.0001;
});

$invoiceTab = isset($_GET['ftab']) ? $_GET['ftab'] : 'alle';
$validInvoiceTabs = array('alle', 'openstaand', 'voldaan');
if (!in_array($invoiceTab, $validInvoiceTabs)) {
    $invoiceTab = 'alle';
}

$filteredInvoices = array_filter($openInvoices, function ($inv) use ($invoiceTab) {
    $due = isset($inv['due']) ? (float) str_replace(',', '.', $inv['due']) : 0;

    if ($invoiceTab === 'openstaand') {
        return $due > 0.0001;
    }
    if ($invoiceTab === 'voldaan') {
        return $due <= 0.0001;
    }
    return true; // alle
});

/* AFSPRAAKHISTORIE */
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

/* NOTIFICATIONS */
$notifications = array();

foreach ($todoInvoices as $inv) {
    $dueNum = isset($inv['due']) ? (float) str_replace(',', '.', $inv['due']) : 0;
    $notifications[] = array(
        'type'  => 'invoice',
        'title' => 'Openstaande factuur #' . $inv['nr'],
        'meta'  => 'Te betalen: €' . number_format($dueNum, 2, ',', '.'),
        'icon'  => 'icons/credit-card-thin.svg',
    );
}

foreach ($todoQuestionnaires as $q) {
    $notifications[] = array(
        'type'  => 'questionnaire',
        'title' => 'Vragenlijst invullen: ' . $q['titel'],
        'meta'  => $q['datum'],
        'icon'  => 'icons/clipboard-text-thin.svg',
    );
}

$hasNotifications = count($notifications) > 0;

function cp_v2_appointment_icon($type) {
    $typeLower = mb_strtolower($type);
    if (strpos($typeLower, 'beeldbellen') !== false) {
        return '../icons/webcam-thin.svg';
    }
    if (strpos($typeLower, 'intake') !== false) {
        return '../icons/user-sound-thin.svg';
    }
    if (strpos($typeLower, 'behandeling') !== false) {
        return '../icons/calendar-dots-thin.svg';
    }
    return '../icons/info-thin.svg';
}
?>