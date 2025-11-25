<?php
// index.php in your new repository

// Optional: set default section so links without ?section work nicely
if (!isset($_GET['section'])) {
    $_GET['section'] = 'overzicht';
}
?>
<!doctype html>
<html lang="nl">
<head>
    <meta charset="utf-8">
    <title>Clientportal v2 prototype</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- hier kun je later je echte CSS-bestand linken -->
</head>
<body>

<?php
// Include your LC3-page-v2 template here
// (use the exact filename you used in the repo)
include 'LC3-page-v2.tpl';
// of: include 'LC3-portal-v2.tpl';
?>

</body>
</html>
