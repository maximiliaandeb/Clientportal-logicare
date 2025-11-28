<div class="cp-v2-modal" id="cp-v2-profile-modal">
    <div class="cp-v2-modal-inner">
        <div class="cp-v2-modal-header">
            <div>
                <h2 class="cp-v2-modal-title">Wijzig profiel</h2>
                <div class="cp-v2-modal-meta">Werk je persoonlijke gegevens bij</div>
            </div>
            <button type="button" class="cp-v2-modal-close" data-modal-close>×</button>
        </div>

        <div class="cp-v2-modal-body">
            <form id="cp-profile-form">
                <div style="display:flex;gap:12px;align-items:center;margin-bottom:8px;">
                    <label style="font-size:13px;color:#6b7280;">Geslacht</label>
                    <label><input type="radio" name="geslacht" value="dhr"> Dhr.</label>
                    <label><input type="radio" name="geslacht" value="mevr"> Mevr.</label>
                </div>

                <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:8px;">
                    <div>
                        <label class="cp-v2-modal-label">Voorletters</label>
                        <input type="text" name="voorletters" class="cp-v2-modal-input" />
                    </div>
                    <div>
                        <label class="cp-v2-modal-label">Tussenvoegsel</label>
                        <input type="text" name="tussenvoegsel" class="cp-v2-modal-input" />
                    </div>
                </div>

                <div style="margin-bottom:8px;">
                    <label class="cp-v2-modal-label">Voornaam</label>
                    <input type="text" name="voornaam" class="cp-v2-modal-input" />
                </div>

                <div style="margin-bottom:8px;">
                    <label class="cp-v2-modal-label">Achternaam</label>
                    <input type="text" name="achternaam" class="cp-v2-modal-input" />
                </div>

                <div style="margin-bottom:8px;">
                    <label class="cp-v2-modal-label">Postadres</label>
                    <input type="text" name="adres" class="cp-v2-modal-input" />
                </div>

                <div style="display:grid;grid-template-columns:120px 1fr;gap:10px;margin-bottom:8px;">
                    <div>
                        <label class="cp-v2-modal-label">Postcode</label>
                        <input type="text" name="postcode" class="cp-v2-modal-input" />
                    </div>
                    <div>
                        <label class="cp-v2-modal-label">Plaats</label>
                        <input type="text" name="plaats" class="cp-v2-modal-input" />
                    </div>
                </div>

                <div style="margin-bottom:8px;">
                    <label class="cp-v2-modal-label">Land</label>
                    <input type="text" name="land" class="cp-v2-modal-input" />
                </div>

                <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:8px;">
                    <div>
                        <label class="cp-v2-modal-label">Telefoon</label>
                        <input type="text" name="telefoon" class="cp-v2-modal-input" />
                    </div>
                    <div>
                        <label class="cp-v2-modal-label">Mobiel</label>
                        <input type="text" name="mobiel" class="cp-v2-modal-input" />
                    </div>
                </div>

                <div style="margin-bottom:4px;">
                    <label class="cp-v2-modal-label">Email</label>
                    <input type="email" name="email" class="cp-v2-modal-input" />
                </div>

            </form>
        </div>

        <div class="cp-v2-modal-footer">
            <button type="button" class="cp-v2-button-secondary" data-modal-close>Annuleren</button>
            <button type="button" class="cp-v2-button-primary" id="cp-profile-save-btn">Opslaan</button>
        </div>
    </div>
</div>
