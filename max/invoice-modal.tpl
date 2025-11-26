<div class="cp-v2-modal-overlay"></div>

<div class="cp-v2-modal" id="cp-v2-invoice-modal">
    <div class="cp-v2-modal-inner">

        <div class="cp-v2-modal-header">
            <div>
                <h2 class="cp-v2-modal-title">Factuur</h2>
                <div class="cp-v2-modal-meta">
                    Factuurnummer <span id="cp-invoice-number"></span>
                </div>
            </div>
            <button type="button"
                    class="cp-v2-modal-close"
                    data-modal-close>
                ×
            </button>
        </div>

        <div class="cp-v2-modal-body">
            <!-- top: praktijk + metadata -->
            <div class="cp-v2-invoice-top">
                <div class="cp-v2-invoice-title-block">
                    <h3><?= htmlspecialchars($client['praktijk_naam']) ?></h3>
                    <p>
                        <?= htmlspecialchars($client['praktijk_url']) ?><br>
                        <?= nl2br(htmlspecialchars($client['adres'])) ?><br>
                        <?= htmlspecialchars($client['plaats']) ?>
                    </p>
                </div>

                <div class="cp-v2-invoice-meta">
                    <dl>
                        <dt>Factuurdatum</dt>
                        <dd id="cp-invoice-date"></dd>

                        <dt>Vervaldatum</dt>
                        <dd id="cp-invoice-due-date">
                            <!-- placeholder; kun je later echt uitrekenen -->
                            14 dagen na factuurdatum
                        </dd>
                    </dl>
                </div>
            </div>

            <!-- billed to -->
            <div class="cp-v2-invoice-billto">
                <div class="cp-v2-invoice-billto-label">Gefactureerd aan</div>
                <div class="cp-v2-invoice-billto-name">
                    <?= htmlspecialchars($client['naam']) ?>
                </div>
                <div class="cp-v2-invoice-billto-text">
                    <!-- hier zou je later cliënt-adres kunnen tonen -->
                    Cliëntnummer: 123456<br>
                    E-mail: <?= htmlspecialchars($client['email']) ?>
                </div>
            </div>

            <!-- lines -->
            <table class="cp-v2-invoice-lines">
                <thead>
                    <tr>
                        <th>Omschrijving</th>
                        <th>Aantal</th>
                        <th>Tarief</th>
                        <th>Totaal</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td id="cp-invoice-line-desc">
                            Behandeling / traject
                        </td>
                        <td>1</td>
                        <td id="cp-invoice-line-rate">€0.00</td>
                        <td id="cp-invoice-line-total">€0.00</td>
                    </tr>
                </tbody>
            </table>

            <!-- totals -->
            <div class="cp-v2-invoice-totals">
                <div class="cp-v2-invoice-totals-inner">
                    <div class="cp-v2-invoice-totals-row">
                        <div class="cp-v2-invoice-totals-label">Subtotaal</div>
                        <div class="cp-v2-invoice-totals-value" id="cp-invoice-subtotal">
                            €0.00
                        </div>
                    </div>
                    <div class="cp-v2-invoice-totals-row" id="cp-invoice-due-row">
                        <div class="cp-v2-invoice-totals-label">Nog te betalen</div>
                        <div class="cp-v2-invoice-totals-value" id="cp-invoice-due">
                            €0.00
                        </div>
                    </div>
                    <div class="cp-v2-invoice-totals-row is-total">
                        <div class="cp-v2-invoice-totals-label">Totaal</div>
                        <div class="cp-v2-invoice-totals-value" id="cp-invoice-total">
                            €0.00
                        </div>
                    </div>
                </div>
            </div>

            <!-- footer info -->
            <div class="cp-v2-invoice-footer">
                <div class="cp-v2-invoice-footer-block">
                    <div class="cp-v2-invoice-footer-title">
                        Praktijkgegevens
                    </div>
                    <p>
                        <?= htmlspecialchars($client['praktijk_naam']) ?><br>
                        <?= htmlspecialchars($client['telefoon']) ?><br>
                        <?= htmlspecialchars($client['email']) ?>
                    </p>
                </div>
                <div class="cp-v2-invoice-footer-block">
                    <div class="cp-v2-invoice-footer-title">
                        Betaalinstructies
                    </div>
                    <p>
                        IBAN: NL00BANK0123456789<br>
                        Betaal binnen 14 dagen o.v.v.
                        factuurnummer.
                    </p>
                </div>
            </div>
        </div>

        <div class="cp-v2-modal-footer">
            <button type="button"
                    class="cp-v2-button-secondary"
                    id="cp-invoice-print-btn">
                Printen
            </button>
            <button type="button"
                    class="cp-v2-button-secondary"
                    data-modal-close>
                Annuleren
            </button>
            <button type="button"
                    class="cp-v2-button-primary"
                    id="cp-invoice-pay-btn">
                Betaal nu
            </button>
        </div>
    </div>
</div>