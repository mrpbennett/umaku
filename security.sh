#!/bin/bash

# Enable automatic security updates
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Install anacron for desktop-friendly scheduling
sudo apt install anacron

# Anti-Malware (ClamAV only - automatic scanning)
sudo apt install clamav clamav-daemon
sudo freshclam  # Update virus definitions
sudo systemctl enable clamav-freshclam  # Auto-update virus definitions
sudo systemctl start clamav-freshclam

# Rootkit Detection (rkhunter only - more comprehensive than chkrootkit)
sudo apt install rkhunter
sudo rkhunter --update

# Intrusion Detection
sudo apt install aide  # Advanced Intrusion Detection Environment
sudo aideinit
sudo aide --check  # Initial check

# Set up automated ClamAV scanning (weekly full system scan)
echo "Setting up weekly ClamAV system scan..."
sudo tee /usr/local/bin/clamav-scan.sh > /dev/null << 'EOF'
#!/bin/bash
# ClamAV Weekly System Scan Script
LOGFILE="/var/log/clamav/clamav-scan.log"
SCAN_DIR="/"
EXCLUDE_DIRS="--exclude-dir=/sys --exclude-dir=/proc --exclude-dir=/dev"

# Create log directory if it doesn't exist
mkdir -p /var/log/clamav

# Run ClamAV scan and log results
echo "=== ClamAV Scan Started: $(date) ===" >> "$LOGFILE"
/usr/bin/clamscan -r $EXCLUDE_DIRS --log="$LOGFILE" --infected "$SCAN_DIR"
echo "=== ClamAV Scan Completed: $(date) ===" >> "$LOGFILE"
echo "" >> "$LOGFILE"
EOF

sudo chmod +x /usr/local/bin/clamav-scan.sh

# Set up automated rkhunter checks (weekly)
echo "Setting up weekly rkhunter checks..."
sudo tee /usr/local/bin/rkhunter-check.sh > /dev/null << 'EOF'
#!/bin/bash
# rkhunter Weekly Check Script
LOGFILE="/var/log/rkhunter/rkhunter-check.log"

# Create log directory if it doesn't exist
mkdir -p /var/log/rkhunter

# Update rkhunter database and run check
echo "=== rkhunter Check Started: $(date) ===" >> "$LOGFILE"
/usr/bin/rkhunter --update --quiet
/usr/bin/rkhunter --check --skip-keypress --report-warnings-only >> "$LOGFILE" 2>&1
echo "=== rkhunter Check Completed: $(date) ===" >> "$LOGFILE"
echo "" >> "$LOGFILE"
EOF

sudo chmod +x /usr/local/bin/rkhunter-check.sh

# Set up weekly AIDE checks via cron
echo "Setting up weekly AIDE integrity checks..."
sudo tee /usr/local/bin/aide-check.sh > /dev/null << 'EOF'
#!/bin/bash
# AIDE Weekly Integrity Check Script
LOGFILE="/var/log/aide/aide-check.log"

# Create log directory if it doesn't exist
mkdir -p /var/log/aide

# Run AIDE check and log results
echo "=== AIDE Check Started: $(date) ===" >> "$LOGFILE"
if /usr/bin/aide --check >> "$LOGFILE" 2>&1; then
    echo "AIDE check completed successfully" >> "$LOGFILE"
else
    echo "AIDE check found changes or errors - please review!" >> "$LOGFILE"
fi
echo "=== AIDE Check Completed: $(date) ===" >> "$LOGFILE"
echo "" >> "$LOGFILE"
EOF

sudo chmod +x /usr/local/bin/aide-check.sh

# Add security checks to anacron (runs missed jobs when computer comes online)
# Format: period_days delay_minutes job_id command
echo "7 10 clamav-scan /usr/local/bin/clamav-scan.sh" | sudo tee -a /etc/anacrontab > /dev/null
echo "7 20 rkhunter-check /usr/local/bin/rkhunter-check.sh" | sudo tee -a /etc/anacrontab > /dev/null
echo "7 30 aide-check /usr/local/bin/aide-check.sh" | sudo tee -a /etc/anacrontab > /dev/null

# Also add daily check during typical desktop hours (6 PM) as fallback
echo "0 18 * * * root /usr/bin/test -x /usr/sbin/anacron && /usr/sbin/anacron -s" | sudo tee -a /etc/crontab > /dev/null

echo ""
echo "=== Security Setup Complete ==="
echo "Desktop-friendly automated security configured with anacron:"
echo "- Automatic security updates: Enabled"
echo "- ClamAV virus scans: Weekly (catches up when computer is on)"
echo "- rkhunter rootkit checks: Weekly (catches up when computer is on)"
echo "- AIDE integrity checks: Weekly (catches up when computer is on)"
echo "- Virus definition updates: Automatic via clamav-freshclam service"
echo "- Anacron check: Daily at 6 PM (when desktop likely to be on)"
echo ""
echo "How it works for desktop users:"
echo "- Jobs run weekly, but catch up automatically when computer is turned on"
echo "- If you miss a week, scans run within 10-30 minutes of next boot"
echo "- No security gaps even if computer is frequently turned off"
echo ""
echo "Logs locations:"
echo "- ClamAV: /var/log/clamav/clamav-scan.log"
echo "- rkhunter: /var/log/rkhunter/rkhunter-check.log"
echo "- AIDE: /var/log/aide/aide-check.log"
echo "- Anacron: /var/log/anacron.log (shows when jobs ran)"
