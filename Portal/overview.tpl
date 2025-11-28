<?php include __DIR__ . '/profile-modal.tpl'; ?>
<?php include __DIR__ . '/password-modal.tpl'; ?>
<?php include __DIR__ . '/question-modal.tpl'; ?>
<?php include __DIR__ . '/callme-modal.tpl'; ?>

<div>
    <div class="cp-v2-section-title">Komende afspraken</div>
    <a href="#" class="cp-v2-button-primary js-open-appointment-modal" style="margin-top:4px;margin-bottom:8px;">
        <img src="../icons/plus-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--white" />
        Maak een nieuwe afspraak
    </a>
    <div class="cp-v2-appointments-row">
        <?php
        // Normalize, sort and limit upcoming appointments so we show the next 3
        $aps = $upcomingAppointments ?: [];
        $getTimestamp = function($d, $t) {
            $dTrim = trim((string)$d);
            $lower = mb_strtolower($dTrim);

            // handle relative labels
            if ($lower === 'morgen' || $lower === 'morning') {
                $dateObj = new DateTime('tomorrow');
            } elseif ($lower === 'vandaag' || $lower === 'today') {
                $dateObj = new DateTime('today');
            } else {
                $dateObj = false;
                // try Dutch common format d/m/Y
                if (strpos($dTrim, '/') !== false) {
                    $dateObj = DateTime::createFromFormat('d/m/Y', $dTrim);
                }
                // fallback to ISO or strtotime parsing
                if (!$dateObj) {
                    $tsTry = strtotime($dTrim);
                    if ($tsTry !== false) {
                        $dateObj = (new DateTime())->setTimestamp($tsTry);
                    }
                }
            }

            if (!$dateObj instanceof DateTime) {
                return PHP_INT_MAX; // unparsable
            }

            // Extract start time from a time range like "13:00–13:30" or "13:00-13:30"
            $timePart = '';
            if (!empty($t)) {
                // split on hyphen or en-dash
                $parts = preg_split('/[\-–—]/u', $t);
                if (!empty($parts) && trim($parts[0]) !== '') {
                    // strip anything that's not digit or colon
                    $timePart = trim(preg_replace('/[^0-9:]/', '', $parts[0]));
                }
            }

            if ($timePart) {
                // combine date with time
                $dateObj->setTime((int)substr($timePart,0,2), (int)substr($timePart,3,2));
            } else {
                // default to start of day
                $dateObj->setTime(0,0,0);
            }

            return $dateObj->getTimestamp();
        };

        // Split into future and past (relative to now) so upcoming items come first
        $now = time();
        $future = [];
        $past = [];
        foreach ($aps as $item) {
            $ts = $getTimestamp($item['date'] ?? '', $item['time'] ?? '');
            if ($ts >= $now) {
                $future[] = $item + ['_ts' => $ts];
            } else {
                $past[] = $item + ['_ts' => $ts];
            }
        }

        usort($future, function($a, $b) { return $a['_ts'] <=> $b['_ts']; });
        usort($past, function($a, $b) { return $a['_ts'] <=> $b['_ts']; });

        // Merge future first, then past; remove the helper _ts before rendering
        $merged = array_map(function($i){ unset($i['_ts']); return $i; }, array_merge($future, $past));
        $aps = array_slice($merged, 0, 3);

        foreach ($aps as $afs): ?>
            <div class="cp-v2-appointment-wrap">
                <div class="cp-v2-appointment-date cp-v2-appointment-date--above">
                    <?= htmlspecialchars($afs['date']) ?>
                </div>
                <article class="cp-v2-appointment-tile" tabindex="0">
                    <div class="cp-v2-appointment-type">
                        <span><?= htmlspecialchars($afs['type']) ?></span>
                    </div>
                    <div class="cp-v2-appointment-time">
                        <?= htmlspecialchars($afs['time']) ?>
                    </div>
                    <img src="<?= cp_v2_appointment_icon($afs['type']) ?>" alt="" class="cp-v2-icon cp-v2-icon--large cp-v2-appointment-icon-right" />
                </article>
            </div>
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
                        <?php if (!empty($q['status']) && $q['status'] === 'voldaan'): ?>
                            <span class="cp-v2-status-pill cp-v2-status-pill--ok">
                                <img src="../icons/check-thing.svg" alt="" class="cp-v2-icon cp-v2-icon--status" />
                            </span>
                        <?php else: ?>
                            <!-- For todo items: render the circular icon image itself (no extra circle) -->
                            <img src="../icons/clock-countdown-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--questionnaire-status" />
                        <?php endif; ?>
                        <a href="#" class="cp-v2-chip-button">
                            <img src="../icons/file-text-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                            Vragenlijst openen
                        </a>
                        <button class="cp-v2-dot-menu" type="button">
                            <img src="../icons/dots-three-vertical-bold.svg" alt="Meer opties" class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--muted" />
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
                            <img src="../icons/credit-card-thin.svg"
                                alt=""
                                class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--primary" />
                            Factuur betalen
                        </a>

                        <button class="cp-v2-dot-menu" type="button">
                            <img src="../icons/dots-three-vertical-bold.svg"
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