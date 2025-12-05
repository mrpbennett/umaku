#!/bin/bash

# Enable automatic security updates
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Anti-Malware
sudo apt install clamav clamtk rkhunter chkrootkit
sudo freshclam  # Update virus definitions
sudo rkhunter --update

# Intrusion Detection
sudo apt install aide  # Advanced Intrusion Detection Environment
sudo aideinit
sudo aide --check  # Run regularly
