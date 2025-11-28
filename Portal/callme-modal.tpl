<div class="cp-v2-modal" id="cp-v2-callme-modal" aria-hidden="true" role="dialog" aria-labelledby="cp-v2-callme-modal-title">
    <div class="cp-v2-modal-inner">
        <div class="cp-v2-modal-header">
            <div>
                <h2 class="cp-v2-modal-title" id="cp-v2-callme-modal-title">Bel me terug</h2>
                <div class="cp-v2-modal-meta">Laat je telefoonnummer achter en we bellen terug</div>
            </div>
            <button type="button" class="cp-v2-modal-close" data-modal-close aria-label="Sluit">×</button>
        </div>

        <div class="cp-v2-modal-body">
            <form id="cp-callme-form">
                <div class="cp-v2-modal-form-row">
                    <label class="cp-v2-modal-label" for="cp-callme-name">Naam*</label>
                    <input id="cp-callme-name" name="naam" type="text" class="cp-v2-modal-input" placeholder="Je volledige naam" />
                </div>

                <div class="cp-v2-modal-form-row">
                    <label class="cp-v2-modal-label" for="cp-callme-phone">Telefoonnummer*</label>
                    <input id="cp-callme-phone" name="telefoon" type="tel" class="cp-v2-modal-input" placeholder="Je telefoonnummer" />
                </div>

                <div class="cp-v2-modal-form-row">
                    <div style="border:1px solid #e6ecef;border-radius:6px;padding:10px;background:#fbfcfd;text-align:center;color:#6b7280;">
                        reCAPTCHA placeholder
                    </div>
                </div>
            </form>
        </div>

        <div class="cp-v2-modal-footer">
            <button type="button" class="cp-v2-button-secondary" data-modal-close>Annuleren</button>
            <button type="button" class="cp-v2-button-primary" id="cp-callme-send-btn">Verzenden</button>
        </div>
    </div>
</div>
