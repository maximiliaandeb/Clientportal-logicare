 <div class="cp-v2-section-title">Facturen</div>

    <?php $baseUrl = '?section=' . urlencode($section); ?>

    <div class="cp-v2-subtabs">
        <a href="<?= $baseUrl ?>&ftab=alle"
           class="cp-v2-subtab <?= $invoiceTab === 'alle' ? 'cp-v2-subtab--active' : '' ?>">
            Alle
        </a>
        <a href="<?= $baseUrl ?>&ftab=openstaand"
           class="cp-v2-subtab <?= $invoiceTab === 'openstaand' ? 'cp-v2-subtab--active' : '' ?>">
            Openstaand
        </a>
        <a href="<?= $baseUrl ?>&ftab=voldaan"
           class="cp-v2-subtab <?= $invoiceTab === 'voldaan' ? 'cp-v2-subtab--active' : '' ?>">
            Voldaan
        </a>
    </div>

    <?php if (empty($filteredInvoices)): ?>
        <p style="font-size:12px;color:#6b7280;margin-top:6px;">
            Er zijn geen facturen in deze categorie.
        </p>
    <?php else: ?>
        <div class="cp-v2-invoice-list">
            <?php foreach ($filteredInvoices as $inv): ?>
                <?php $due = (float) str_replace(',', '.', $inv['due']); ?>
                <div class="cp-v2-invoice-row"
                    data-invoice-nr="<?= (int) $inv['nr'] ?>"
                    data-invoice-date="<?= htmlspecialchars($inv['date']) ?>"
                    data-invoice-total="<?= htmlspecialchars($inv['total']) ?>"
                    data-invoice-due="<?= htmlspecialchars($inv['due']) ?>">

                    <div class="cp-v2-invoice-main">
                        <a href="#"
                        class="cp-v2-invoice-number">
                            <?= (int) $inv['nr'] ?>
                        </a>
                        <div class="cp-v2-invoice-date">
                            <?= htmlspecialchars($inv['date']) ?>
                        </div>
                    </div>

                    <div class="cp-v2-invoice-amounts">
                        <div class="cp-v2-invoice-amount-block">
                            <div class="cp-v2-invoice-label">Totaal</div>
                            <div class="cp-v2-invoice-value">
                                €<?= htmlspecialchars($inv['total']) ?>
                            </div>
                        </div>
                        <div class="cp-v2-invoice-amount-block">
                            <div class="cp-v2-invoice-label">Te betalen</div>
                            <div class="cp-v2-invoice-value">
                                €<?= htmlspecialchars($inv['due']) ?>
                            </div>
                        </div>
                    </div>

                    <div class="cp-v2-invoice-status">
                        <?php if ($due > 0.0001): ?>
                            <!-- openstaand: creditcard + rood bolletje -->
                            <button type="button"
                                    class="cp-v2-status-pill cp-v2-status-pill--alert cp-v2-invoice-open">
                                <span class="cp-v2-status-pill-badge"></span>
                                <img src="icons/credit-card-thin.svg"
                                    alt=""
                                    class="cp-v2-icon cp-v2-icon--status" />
                            </button>
                        <?php else: ?>
                            <!-- voldaan: groene check -->
                            <button type="button"
                                    class="cp-v2-status-pill cp-v2-status-pill--ok cp-v2-invoice-open">
                                <img src="icons/check-bold.svg"
                                    alt=""
                                    class="cp-v2-icon cp-v2-icon--status" />
                            </button>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endforeach; ?>

        </div>
    <?php endif; ?>
</div>