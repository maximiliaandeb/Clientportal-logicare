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
                            <img src="../icons/check-circle-thin.svg"
                                 alt=""
                                 class="cp-v2-icon cp-v2-icon--status" />
                        </span>
                    <?php else: ?>
                        <!-- Clock + rood bolletje voor 'Te doen' -->
                        <span class="cp-v2-status-pill cp-v2-status-pill--alert">
                            <span class="cp-v2-status-pill-badge"></span>
                            <img src="../icons/clock-countdown-thin.svg"
                                 alt=""
                                 class="cp-v2-icon cp-v2-icon--status" />
                        </span>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>