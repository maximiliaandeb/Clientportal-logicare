<div>
    <div class="cp-v2-section-title">Komende afspraken</div>
    <a href="#" class="cp-v2-button-primary" style="margin-top:4px;margin-bottom:8px;">
        <img src="../icons/plus-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny cp-v2-icon--white" />
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
                            <img src="../icons/file-archive-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                        </span>
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