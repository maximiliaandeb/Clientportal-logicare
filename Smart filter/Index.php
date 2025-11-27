<?php
// Simple PHP entry to render the smart filter TPL.
// Define the diagnoses list here so the TPL can use it.

$diagnoses = [
    "Diabetes mellitus type 2",
    "Hypertensie",
    "Astma",
    "COPD",
    "Acute sinusitis",
    "Otitis media",
    "Migraine",
    "Depressie",
    "Angina pectoris",
    "Hartfalen",
    "Hypothyreoïdie",
    "Anemie",
    "Artritis",
    "Osteoartritis",
    "Rheumatoïde artritis",
    "Gastro-oesofageale reflux",
    "Peptisch ulcus",
    "Irritable bowel syndrome (IBS)",
    "Chronische nierziekte",
    "Urineweginfectie",
    "Benigne paroxismale positieduizeligheid (BPPD)",
    "Ziekte van Parkinson",
    "Multiple sclerose",
    "Allergische rhinitis",
    "Sepsis",
    "Longembolie",
    "COVID-19",
    "Pneumonie",
    "Dermatitis atopica",
    "Psoriasis"
];

// Include the TPL — the TPL expects $diagnoses to be available
require __DIR__ . '/smart-filter.tpl';

?>
