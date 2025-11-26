<?php
// index.php in your new repository

// Optional: set default section so links without ?section work nicely
if (!isset($_GET['section'])) {
    $_GET['section'] = 'overzicht';
}

// Include the page data (variables + helpers) so the widget templates can access them
include __DIR__ . '/cp-page-data.php';
?>
<!doctype html>
<html lang="nl">
<head>

    <meta charset="utf-8">
    <title>Sidebar top</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- hier kun je later je echte CSS-bestand linken -->
<link rel="stylesheet" href="../main.css?v=1">


</head>
<body>

<?php
// Include your LC3-page-v2 template here
// (use the exact filename you used in the repo)
include 'main.tpl';
// of: include 'LC3-portal-v2.tpl';
?>

</body>
</html>