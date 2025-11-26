<div class="sidebar">
    <div class="logo">
        <img src="path/to/logo.png" alt="Logo">
    </div>

    <div class="client-card">
        <p><strong><?= htmlspecialchars($client['naam']) ?></strong></p>
        <p><?= isset($client['birthdate']) ? htmlspecialchars($client['birthdate']) : '' ?></p>
        <p><?= isset($client['address_line1']) ? htmlspecialchars($client['address_line1']) : '' ?></p>
        <p><?= isset($client['address_line2']) ? htmlspecialchars($client['address_line2']) : '' ?></p>
    </div>

    <div class="menu">
        <a href="#" class="menu-item">
            <span class="icon">👤</span> Wijzig profiel
        </a>

        <a href="#" class="menu-item">
            <span class="icon">🔑</span> Wijzig wachtwoord
        </a>

        <a href="#" class="menu-item">
            <span class="icon">📞</span> Bel me terug
        </a>

        <a href="#" class="menu-item">
            <span class="icon">⬇️</span> Downloads
        </a>

        <a href="#" class="menu-item">
            <span class="icon">📄</span> Documenten
        </a>

        <a href="#" class="menu-item logout">
            <span class="icon">↩️</span> Uitloggen
        </a>
    </div>
</div>
