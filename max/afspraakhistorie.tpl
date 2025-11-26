  <div class="cp-v2-card cp-v2-right-section">
                <div class="cp-v2-section-title">Afspraakshistorie</div>

                <div class="cp-v2-timeline">
                    <?php foreach ($historyAppointments as $group): ?>
                        <div class="cp-v2-timeline-row">
                            <div class="cp-v2-timeline-axis">
                                <div class="cp-v2-timeline-dot"></div>
                            </div>

                            <div class="cp-v2-timeline-content">
                                <div class="cp-v2-timeline-label">
                                    <?= htmlspecialchars($group['label']) ?>
                                </div>

                                <?php foreach ($group['items'] as $item): ?>
                                    <div class="cp-v2-timeline-item">
                                        <div class="cp-v2-timeline-item-icon">
                                            <img src="<?= cp_v2_appointment_icon($item['type']) ?>"
                                                alt=""
                                                class="cp-v2-icon cp-v2-icon--tiny" />
                                        </div>
                                        <div class="cp-v2-timeline-item-text">
                                            <span class="cp-v2-timeline-time">
                                                <?= htmlspecialchars($item['time']) ?>
                                            </span>
                                            <span class="cp-v2-timeline-type">
                                                <?= htmlspecialchars($item['type']) ?>
                                            </span>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>