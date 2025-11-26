document.addEventListener('DOMContentLoaded', function () {
    const overlay = document.querySelector('.cp-v2-modal-overlay');
    const modal   = document.querySelector('.cp-v2-modal');
    const modalInner = modal ? modal.querySelector('.cp-v2-modal-inner') : null;
    if (!overlay || !modal || !modalInner) return;

    const body = document.body;

    // invoice fields in modal
    const elNr       = document.getElementById('cp-invoice-number');
    const elDate     = document.getElementById('cp-invoice-date');
    const elLineRate = document.getElementById('cp-invoice-line-rate');
    const elLineTotal= document.getElementById('cp-invoice-line-total');
    const elSubtotal = document.getElementById('cp-invoice-subtotal');
    const elTotal    = document.getElementById('cp-invoice-total');
    const elDue      = document.getElementById('cp-invoice-due');
    const elDueRow   = document.getElementById('cp-invoice-due-row');

    const btnPrint   = document.getElementById('cp-invoice-print-btn');
    const btnPay     = document.getElementById('cp-invoice-pay-btn');

    /* ---------- helpers ---------- */

    function openModal() {
        overlay.classList.add('cp-v2-modal-overlay--visible');
        modal.classList.add('cp-v2-modal--visible');
        body.classList.add('cp-v2-modal-open');
    }

    function closeModal() {
        modal.classList.remove('cp-v2-modal--visible');
        overlay.classList.remove('cp-v2-modal-overlay--visible');
        body.classList.remove('cp-v2-modal-open');
    }

    function formatEuro(value) {
        const num = parseFloat(String(value).replace(',', '.')) || 0;
        return '€' + num.toFixed(2).replace('.', ',');
    }

    function fillInvoiceFromRow(row) {
        const nr    = row.dataset.invoiceNr || '';
        const date  = row.dataset.invoiceDate || '';
        const total = row.dataset.invoiceTotal || '0.00';
        const due   = row.dataset.invoiceDue || '0.00';

        const totalNum = parseFloat(String(total).replace(',', '.')) || 0;
        const dueNum   = parseFloat(String(due).replace(',', '.')) || 0;

        if (elNr)       elNr.textContent       = nr;
        if (elDate)     elDate.textContent     = date;
        if (elLineRate) elLineRate.textContent = formatEuro(totalNum);
        if (elLineTotal)elLineTotal.textContent= formatEuro(totalNum);
        if (elSubtotal) elSubtotal.textContent = formatEuro(totalNum);
        if (elTotal)    elTotal.textContent    = formatEuro(totalNum);
        if (elDue)      elDue.textContent      = formatEuro(dueNum);

        const isPaid = dueNum <= 0.0001;

        if (elDueRow) {
            elDueRow.style.display = isPaid ? 'none' : 'flex';
        }
        if (btnPay) {
            btnPay.style.display = isPaid ? 'none' : 'inline-flex';
            btnPay.disabled = isPaid;
        }
    }

    /* ---------- openers on invoice rows ---------- */

    document.querySelectorAll('.cp-v2-invoice-row').forEach(row => {
        // both the pill and the number open the modal
        row.querySelectorAll('.cp-v2-invoice-open, .cp-v2-invoice-number')
            .forEach(trigger => {
                trigger.addEventListener('click', function (e) {
                    e.preventDefault();
                    fillInvoiceFromRow(row);
                    openModal();
                });
            });
    });

    /* ---------- openers on main table "Factuur betalen" buttons ---------- */

    document.querySelectorAll('.js-open-invoice-modal').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();

            // use the same helper, it just needs an element with the right data-*
            fillInvoiceFromRow(btn);
            openModal();
        });
    });


    /* ---------- closing ---------- */

    overlay.addEventListener('click', function () {
        closeModal();
    });

    modal.querySelectorAll('[data-modal-close]').forEach(btn => {
        btn.addEventListener('click', function () {
            closeModal();
        });
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });

    /* ---------- print ---------- */

    if (btnPrint) {
        btnPrint.addEventListener('click', function () {
            window.print();
        });
    }

    /* ---------- fake pay action for now ---------- */

    if (btnPay) {
        btnPay.addEventListener('click', function () {
            // hier kun je later naar Mollie/Ideal/whatever redirecten
            alert('Betaalflow kan hier gestart worden 🙂');
        });
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const bell = document.getElementById('cp-main-notify-btn');
    const dropdown = document.getElementById('cp-main-notify-dropdown');

    if (!bell || !dropdown) return;

    function openDropdown() {
        dropdown.classList.add('cp-v2-notify-dropdown--visible');
        bell.setAttribute('aria-expanded', 'true');
    }

    function closeDropdown() {
        dropdown.classList.remove('cp-v2-notify-dropdown--visible');
        bell.setAttribute('aria-expanded', 'false');
    }

    function toggleDropdown() {
        if (dropdown.classList.contains('cp-v2-notify-dropdown--visible')) {
            closeDropdown();
        } else {
            openDropdown();
        }
    }

    bell.addEventListener('click', function (e) {
        e.stopPropagation();
        toggleDropdown();
    });

    // Klikken in de dropdown mag hem niet meteen sluiten
    dropdown.addEventListener('click', function (e) {
        e.stopPropagation();
    });

    // Klik ergens anders op de pagina => dropdown dicht
    document.addEventListener('click', function () {
        closeDropdown();
    });

    // ESC sluit de dropdown
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            closeDropdown();
        }
    });
});
