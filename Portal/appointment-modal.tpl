<div class="cp-v2-modal" id="cp-v2-appointment-modal">
    <div class="cp-v2-modal-inner">

        <div class="cp-v2-modal-header">
            <div>
                <h2 class="cp-v2-modal-title">Maak een nieuwe afspraak</h2>
                <div class="cp-v2-modal-meta">
                    Kies het type afspraak en een geschikte datum
                </div>
            </div>
            <button type="button"
                    class="cp-v2-modal-close"
                    data-modal-close>
                ×
            </button>
        </div>

        <div class="cp-v2-modal-body">
            <div class="cp-v2-appointment-layout">
                <div class="cp-v2-appointment-options">
                    <button type="button" class="cp-v2-appointment-option cp-v2-button-primary" data-apt-type="video">
                        <img src="../icons/video-camera-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                        <span>Beelbellen</span>
                    </button>

                    <button type="button" class="cp-v2-appointment-option cp-v2-button-secondary" data-apt-type="treatment">
                        <img src="../icons/calendar-dots-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                        <span>Behandeling 60 min</span>
                    </button>

                    <button type="button" class="cp-v2-appointment-option cp-v2-button-secondary" data-apt-type="phone">
                        <img src="../icons/phone-call-thin.svg" alt="" class="cp-v2-icon cp-v2-icon--tiny" />
                        <span>Belafspraak 15 min</span>
                    </button>
                </div>

                <div class="cp-v2-appointment-calendar">
                    <!-- Simple calendar placeholder. Style as needed in CSS. -->
                    <div class="cp-v2-calendar">
                        <div class="cp-v2-calendar-header">November 2025</div>
                        <div class="cp-v2-calendar-grid">
                            <div class="cp-v2-calendar-day">Ma</div>
                            <div class="cp-v2-calendar-day">Din</div>
                            <div class="cp-v2-calendar-day">Woe</div>
                            <div class="cp-v2-calendar-day">Don</div>
                            <div class="cp-v2-calendar-day">Vri</div>
                            <div class="cp-v2-calendar-day">Zat</div>
                            <div class="cp-v2-calendar-day">Zon</div>
                            <!-- days (placeholder) -->
                            <?php for ($d=27;$d<=30;$d++): ?>
                                <div class="cp-v2-calendar-cell cp-v2-calendar-cell--past" data-day="<?= $d ?>"><?= $d ?></div>
                            <?php endfor; ?>
                            <?php for ($d=1;$d<=7;$d++): ?>
                                <div class="cp-v2-calendar-cell" data-day="<?= $d ?>"><?= $d ?></div>
                            <?php endfor; ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="cp-v2-modal-footer">
            <button type="button" class="cp-v2-button-secondary" data-modal-close>Annuleren</button>
            <button type="button" class="cp-v2-button-primary" id="cp-appointment-create-btn">Maak afspraak</button>
        </div>
    </div>
</div>
