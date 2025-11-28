<?php
// index.php in your new repository

// Zorg dat er altijd een geldige section is,
// zodat links zonder ?section gewoon "Overzicht" tonen.
if (!isset($_GET['section'])) {
    $_GET['section'] = 'overzicht';
}

// Include de data + helpers zodat de template erbij kan
include __DIR__ . '/cp-page-data.php';
?>
<!doctype html>
<html lang="nl">
<head>
    <meta charset="utf-8">
    <title>Cliëntportaal</title>

    <!-- Belangrijk voor responsive gedrag op telefoon -->
    <meta name="viewport"
          content="width=device-width, initial-scale=1, viewport-fit=cover">

    <!-- Basis styles -->
    <link rel="stylesheet" href="../main.css?v=1">

    <!-- Phone-specific media queries (worden in de file zelf met @media geactiveerd) -->
    <link rel="stylesheet" href="../mediaqueries-phone-cp.css?v=1">
</head>
<body>

<?php
// Hoofdtemplate van de portal
include __DIR__ . '/main.tpl';   // of: 'LC3-portal-v2.tpl' als je die naam gebruikt
?>

</body>
</html>
