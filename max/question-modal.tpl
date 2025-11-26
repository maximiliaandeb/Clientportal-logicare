<div class="cp-v2-modal" id="cp-v2-question-modal" aria-hidden="true" role="dialog" aria-labelledby="cp-v2-question-modal-title">
    <div class="cp-v2-modal-inner">
        <div class="cp-v2-modal-header">
            <div>
                <h2 class="cp-v2-modal-title" id="cp-v2-question-modal-title">Stel een vraag</h2>
                <div class="cp-v2-modal-meta">Stuur ons een bericht — we reageren per e-mail</div>
            </div>
            <button type="button" class="cp-v2-modal-close" data-modal-close aria-label="Sluit">×</button>
        </div>

        <div class="cp-v2-modal-body">
            <form id="cp-question-form">
                <div class="cp-v2-modal-form-row">
                    <label class="cp-v2-modal-label" for="cp-question-text">Vraag*</label>
                    <textarea id="cp-question-text" name="vraag" class="cp-v2-modal-input" rows="4" placeholder="Stel hier je vraag ..."></textarea>
                </div>

                <div class="cp-v2-modal-form-row">
                    <label class="cp-v2-modal-label" for="cp-question-name">Naam*</label>
                    <input id="cp-question-name" name="naam" type="text" class="cp-v2-modal-input" />
                </div>

                <div class="cp-v2-modal-form-row">
                    <label class="cp-v2-modal-label" for="cp-question-email">Email*</label>
                    <input id="cp-question-email" name="email" type="email" class="cp-v2-modal-input" />
                </div>

                <!-- reCAPTCHA placeholder (server key required to enable) -->
                <div class="cp-v2-modal-form-row">
                    <div style="border:1px solid #e6ecef;border-radius:6px;padding:10px;background:#fbfcfd;text-align:center;color:#6b7280;">
                        reCAPTCHA placeholder
                    </div>
                </div>
            </form>
        </div>

        <div class="cp-v2-modal-footer">
            <button type="button" class="cp-v2-button-secondary" data-modal-close>Annuleren</button>
            <button type="button" class="cp-v2-button-primary" id="cp-question-send-btn">Verzenden</button>
        </div>
    </div>
</div>
