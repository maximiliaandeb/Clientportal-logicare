document.addEventListener('DOMContentLoaded', function () {
    let overlay = document.querySelector('.cp-v2-modal-overlay');
    const modals  = Array.from(document.querySelectorAll('.cp-v2-modal'));
    // Ensure an overlay exists on the page. Some pages include it via templates,
    // but if it's missing (e.g. this partial is rendered standalone) create one.
    if (!overlay) {
        overlay = document.createElement('div');
        overlay.className = 'cp-v2-modal-overlay';
        document.body.appendChild(overlay);
    }

    const body = document.body;

    /* ---------- modal helpers (multi-modal) ---------- */
    function openModal(modalEl) {
        if (!modalEl) return;
        modals.forEach(m => m.classList.remove('cp-v2-modal--visible'));
        overlay.classList.add('cp-v2-modal-overlay--visible');
        modalEl.classList.add('cp-v2-modal--visible');
        body.classList.add('cp-v2-modal-open');
    }

    function closeModal() {
        modals.forEach(m => m.classList.remove('cp-v2-modal--visible'));
        overlay.classList.remove('cp-v2-modal-overlay--visible');
        body.classList.remove('cp-v2-modal-open');
    }

    /* ---------- invoice-specific elements & helpers ---------- */
    const invoiceModal = document.getElementById('cp-v2-invoice-modal');
    let elNr, elDate, elLineRate, elLineTotal, elSubtotal, elTotal, elDue, elDueRow, btnPrint, btnPay;
    if (invoiceModal) {
        elNr       = invoiceModal.querySelector('#cp-invoice-number');
        elDate     = invoiceModal.querySelector('#cp-invoice-date');
        elLineRate = invoiceModal.querySelector('#cp-invoice-line-rate');
        elLineTotal= invoiceModal.querySelector('#cp-invoice-line-total');
        elSubtotal = invoiceModal.querySelector('#cp-invoice-subtotal');
        elTotal    = invoiceModal.querySelector('#cp-invoice-total');
        elDue      = invoiceModal.querySelector('#cp-invoice-due');
        elDueRow   = invoiceModal.querySelector('#cp-invoice-due-row');
        btnPrint   = invoiceModal.querySelector('#cp-invoice-print-btn');
        btnPay     = invoiceModal.querySelector('#cp-invoice-pay-btn');
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
        row.querySelectorAll('.cp-v2-invoice-open, .cp-v2-invoice-number')
            .forEach(trigger => {
                trigger.addEventListener('click', function (e) {
                    e.preventDefault();
                    fillInvoiceFromRow(row);
                    if (invoiceModal) openModal(invoiceModal);
                });
            });
    });

    /* ---------- openers on main table "Factuur betalen" buttons ---------- */
    document.querySelectorAll('.js-open-invoice-modal').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            fillInvoiceFromRow(btn);
            if (invoiceModal) openModal(invoiceModal);
        });
    });

    /* ---------- openers for appointment modal ---------- */
    const appointmentModal = document.getElementById('cp-v2-appointment-modal');
    document.querySelectorAll('.js-open-appointment-modal').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            if (appointmentModal) openModal(appointmentModal);
        });
    });

    /* ---------- openers for profile / quick-modals on left sidebar ---------- */
    const profileModal = document.getElementById('cp-v2-profile-modal');
    document.querySelectorAll('.js-open-profile-modal').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            if (profileModal) openModal(profileModal);
        });
    });

    // simple save handler for the profile modal (placeholder - no server persistence)
    if (profileModal) {
        const profileForm = profileModal.querySelector('#cp-profile-form');
        const profileSaveBtn = profileModal.querySelector('#cp-profile-save-btn');
        if (profileSaveBtn) {
            profileSaveBtn.addEventListener('click', function (e) {
                e.preventDefault();
                // Basic validation: require an email
                const emailEl = profileForm.querySelector('input[name="email"]');
                if (emailEl && !emailEl.value.trim()) {
                    alert('Vul een geldig e-mailadres in');
                    emailEl.focus();
                    return;
                }
                // TODO: send data to server via fetch/XHR - currently just confirm
                alert('Profiel opgeslagen (placeholder)');
                closeModal();
            });
        }
    }

    // placeholders for other left-side quick-modals (if implemented later)
    const passwordModal = document.getElementById('cp-v2-password-modal');
    document.querySelectorAll('.js-open-password-modal').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            if (passwordModal) openModal(passwordModal);
        });
    });

    // simple save handler for change-password modal (placeholder)
    if (passwordModal) {
        const pwForm = passwordModal.querySelector('#cp-password-form');
        const pwSaveBtn = passwordModal.querySelector('#cp-password-save-btn');
        if (pwSaveBtn) {
            pwSaveBtn.addEventListener('click', function (e) {
                e.preventDefault();
                const pw = pwForm.querySelector('input[name="password"]');
                const pwc = pwForm.querySelector('input[name="password_confirm"]');
                if (!pw || !pwc) return;
                if (!pw.value.trim()) {
                    alert('Vul een nieuw wachtwoord in');
                    pw.focus();
                    return;
                }
                if (pw.value !== pwc.value) {
                    alert('Wachtwoorden komen niet overeen');
                    pwc.focus();
                    return;
                }
                // TODO: send POST to server. For now show placeholder confirmation
                alert('Wachtwoord gewijzigd (placeholder)');
                closeModal();
            });
        }
    }

    // simple handler for 'Stel een vraag' modal (placeholder)
    if (typeof document !== 'undefined') {
        const questionModalEl = document.getElementById('cp-v2-question-modal');
        if (questionModalEl) {
            const qForm = questionModalEl.querySelector('#cp-question-form');
            const qSendBtn = questionModalEl.querySelector('#cp-question-send-btn');
            if (qSendBtn) {
                qSendBtn.addEventListener('click', function (e) {
                    e.preventDefault();
                    const vraag = qForm.querySelector('textarea[name="vraag"]');
                    const naam = qForm.querySelector('input[name="naam"]');
                    const email = qForm.querySelector('input[name="email"]');
                    if (!vraag || !vraag.value.trim()) {
                        alert('Vul uw vraag in');
                        vraag.focus();
                        return;
                    }
                    if (!naam || !naam.value.trim()) {
                        alert('Vul uw naam in');
                        naam.focus();
                        return;
                    }
                    if (!email || !email.value.trim()) {
                        alert('Vul uw e-mailadres in');
                        email.focus();
                        return;
                    }
                    // TODO: POST to server endpoint; for now just confirm
                    alert('Vraag verzonden (placeholder).');
                    closeModal();
                });
            }
        }
    }

    // simple handler for 'Bel me terug' modal (placeholder)
    const callmeModalEl = document.getElementById('cp-v2-callme-modal');
    if (callmeModalEl) {
        const callForm = callmeModalEl.querySelector('#cp-callme-form');
        const callSendBtn = callmeModalEl.querySelector('#cp-callme-send-btn');
        if (callSendBtn) {
            callSendBtn.addEventListener('click', function (e) {
                e.preventDefault();
                const naam = callForm.querySelector('input[name="naam"]');
                const telefoon = callForm.querySelector('input[name="telefoon"]');
                if (!naam || !naam.value.trim()) {
                    alert('Vul uw naam in');
                    if (naam) naam.focus();
                    return;
                }
                if (!telefoon || !telefoon.value.trim()) {
                    alert('Vul uw telefoonnummer in');
                    if (telefoon) telefoon.focus();
                    return;
                }
                // TODO: POST to server endpoint; for now just confirm
                alert('Verzoek ontvangen — we bellen u terug (placeholder).');
                closeModal();
            });
        }
    }

    const callmeModal = document.getElementById('cp-v2-callme-modal');
    document.querySelectorAll('.js-open-callme-modal').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            if (callmeModal) openModal(callmeModal);
        });
    });

    const questionModal = document.getElementById('cp-v2-question-modal');
    document.querySelectorAll('.js-open-question-modal').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            if (questionModal) openModal(questionModal);
        });
    });

    /* ---------- appointment modal interactions ---------- */
    if (appointmentModal) {
        const optionButtons = Array.from(appointmentModal.querySelectorAll('.cp-v2-appointment-option'));
        const calendarCells = Array.from(appointmentModal.querySelectorAll('.cp-v2-calendar-cell'));
        const createBtn = appointmentModal.querySelector('#cp-appointment-create-btn');
        let selectedType = null;
        let selectedDate = null;

        // default: select first type
        if (optionButtons.length) {
            optionButtons.forEach(b => b.classList.remove('is-selected'));
            optionButtons[0].classList.add('is-selected');
            selectedType = optionButtons[0].dataset.aptType || null;
        }

        optionButtons.forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault();
                optionButtons.forEach(b => {
                    b.classList.remove('is-selected');
                    // swap primary/secondary classes so selected looks primary
                    b.classList.remove('cp-v2-button-primary');
                    b.classList.add('cp-v2-button-secondary');
                    // ensure icon color reset
                    const icon = b.querySelector('.cp-v2-icon');
                    if (icon) icon.classList.remove('cp-v2-icon--white');
                });
                btn.classList.add('is-selected');
                btn.classList.remove('cp-v2-button-secondary');
                btn.classList.add('cp-v2-button-primary');
                // make selected icon white
                const selIcon = btn.querySelector('.cp-v2-icon');
                if (selIcon) selIcon.classList.add('cp-v2-icon--white');
                selectedType = btn.dataset.aptType || null;
            });
        });

        calendarCells.forEach(cell => {
            cell.addEventListener('click', function (e) {
                e.preventDefault();
                calendarCells.forEach(c => c.classList.remove('is-selected'));
                cell.classList.add('is-selected');
                // store date; if cell has data-day use it, else use text
                selectedDate = cell.dataset.day || cell.textContent.trim();
            });
        });

        if (createBtn) {
            createBtn.addEventListener('click', function () {
                if (!selectedType) {
                    alert('Kies eerst het type afspraak');
                    return;
                }
                if (!selectedDate) {
                    alert('Kies eerst een datum');
                    return;
                }
                // For now just show a confirmation; later POST to server
                alert('Maak afspraak: ' + selectedType + ' op ' + selectedDate);
                closeModal();
            });
        }
    }

    /* ---------- closing ---------- */
    overlay.addEventListener('click', function () { closeModal(); });

    document.querySelectorAll('.cp-v2-modal [data-modal-close]').forEach(btn => {
        btn.addEventListener('click', function () { closeModal(); });
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });

    /* ---------- print ---------- */
    if (btnPrint) {
        btnPrint.addEventListener('click', function () { window.print(); });
    }

    /* ---------- fake pay action for now ---------- */
    if (btnPay) {
        btnPay.addEventListener('click', function () {
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
