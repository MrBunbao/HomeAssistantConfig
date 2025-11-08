# Home Assistant Setup Guide

This document explains how to set up a similar Home Assistant configuration.

## Prerequisites

### Hardware Requirements
- **Host System**: x86_64 compatible hardware (physical or virtual)
- **RAM**: Minimum 2GB, 4GB+ recommended
- **Storage**: 32GB+ SSD/NVMe recommended
- **Network**: Ethernet connection recommended

### Smart Home Hubs
- Lutron Caseta Smart Bridge Pro (for Lutron devices)
- Philips Hue Bridge (for Hue devices)
- Zigbee USB dongle (for Zigbee2MQTT) or SkyConnect
- Z-Wave USB stick (for Z-Wave devices)

## Installation

### Option 1: Virtual Machine (Proxmox)
This is the recommended setup as shown in this configuration.

1. **Create VM in Proxmox**
   - Download Home Assistant OS image (qemux86-64)
   - Create new VM with:
     - 2+ CPU cores
     - 4GB+ RAM
     - 32GB+ disk space
   - Attach HA OS image as boot disk

2. **First Boot**
   - Boot the VM
   - Wait for initial setup (5-10 minutes)
   - Access web interface at `http://homeassistant.local:8123`

3. **Initial Configuration**
   - Create admin account
   - Set location and timezone
   - Configure network settings

### Option 2: Dedicated Hardware
- Use Home Assistant Blue, Yellow, or Green
- Flash Home Assistant OS to NUC or similar hardware
- Follow on-screen setup wizard

### Option 3: Container/Supervised
- Install Docker
- Run Home Assistant Container
- Note: Some add-ons may not be available

## Network Configuration

### Static IP Address
Recommended for reliable access and automation.

**In Proxmox/VM**:
1. Settings → System → Network
2. Configure IPv4:
   - Address: `10.10.10.5` (or your choice)
   - Netmask: `255.255.255.0`
   - Gateway: Your router IP
   - DNS: Your DNS server

### Firewall Rules
Allow incoming connections:
- Port 8123 (HTTP interface)
- Port 4357 (Observer/mDNS)
- Port 21063 (HomeKit)

## Integration Setup

### 1. Install HACS
```bash
# SSH into Home Assistant
# Download HACS installation script
wget -O - https://get.hacs.xyz | bash -
```

Then:
1. Restart Home Assistant
2. Add HACS integration via UI
3. Authenticate with GitHub

### 2. Lutron Caseta Setup
1. Install Lutron Caseta integration
2. Follow certificate pairing process
3. Pair devices through Lutron app first
4. Certificates saved as `lutron_caseta-*-{ca,cert,key}.pem`

### 3. Philips Hue Setup
1. Integration auto-discovers Hue Bridge
2. Press bridge button when prompted
3. Select devices to import
4. Configure rooms and zones

### 4. iCloud3 Setup (via HACS)
1. Install iCloud3 from HACS
2. Add integration via UI
3. Provide iCloud credentials
4. Configure tracked devices
5. Set up zones for presence detection

### 5. ESPHome Devices
1. Install ESPHome add-on
2. Create device configurations
3. Flash devices via USB or OTA
4. Devices auto-discovered in HA

## SSH Access Setup

### Enable SSH Add-on
1. Settings → Add-ons → Terminal & SSH
2. Configuration → Add SSH public key
3. Set port (default 22)
4. Start add-on

### Generate SSH Key (if needed)
```bash
ssh-keygen -t ed25519 -C "homeassistant"
```

Add public key to Terminal & SSH add-on configuration.

## GitHub Backup Setup

### 1. Create GitHub Repository
```bash
# On Home Assistant host
gh auth login
gh repo create HomeAssistantConfig --public
```

### 2. Configure Git
```bash
cd /homeassistant
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### 3. Set Up Remote
```bash
git remote add origin git@github.com:YourUsername/HomeAssistantConfig.git
```

### 4. Initial Commit
```bash
git add .gitignore README.md configuration.yaml automations.yaml
git commit -m "Initial commit"
git push -u origin main
```

### 5. Add Automation
The automated backup automation is included in `automations.yaml`:
- Runs daily at 2:00 AM
- Also runs on HA restart
- Commits and pushes changes automatically

## Security Configuration

### Create secrets.yaml
```yaml
# Example secrets.yaml structure
# Lutron
lutron_host: 192.168.1.x
lutron_keyfile: /ssl/lutron/caseta.key
lutron_certfile: /ssl/lutron/caseta.crt
lutron_ca_certs: /ssl/lutron/caseta-bridge.crt

# Wake on LAN
wakeonlan_andyspc_mac: "XX:XX:XX:XX:XX:XX"
wakeonlan_andyspc_hostip: "192.168.1.x"

# API Keys
openai_api_key: "sk-..."
hue_api_key: "..."

# iCloud
icloud_username: "your@email.com"
icloud_password: "your-password"
```

### Update .gitignore
Ensure `.gitignore` excludes:
- `secrets.yaml`
- `*.db*` (databases)
- `*.log*` (logs)
- `*.pem`, `*.key`, `*.cert` (certificates)
- `.storage/` (internal storage)

## Recommended Add-ons

Install these from Settings → Add-ons:

**Essential**:
- Terminal & SSH
- File Editor
- Samba Share (for easy file access)

**Useful**:
- ESPHome
- Mosquitto broker (for MQTT)
- Zigbee2MQTT
- Z-Wave JS

**Optional**:
- Studio Code Server
- MariaDB (for advanced database needs)
- InfluxDB + Grafana (for advanced monitoring)

## Custom Component Installation

### Via HACS
1. HACS → Integrations
2. Search for integration
3. Install
4. Restart Home Assistant
5. Add integration via Settings → Integrations

### Manual Installation
1. Download integration
2. Extract to `/config/custom_components/`
3. Restart Home Assistant

## Configuration Best Practices

### 1. Use Packages (Optional)
Split configuration into logical files:
```yaml
# configuration.yaml
homeassistant:
  packages: !include_dir_named packages/
```

### 2. Use Secrets
Never hardcode credentials:
```yaml
# WRONG
api_key: "abc123"

# RIGHT
api_key: !secret my_api_key
```

### 3. Use Includes
Keep files manageable:
```yaml
automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml
```

### 4. Document Everything
- Use comments in YAML
- Maintain README and docs/
- Keep changelog of major changes

### 5. Version Control
- Commit changes regularly
- Use meaningful commit messages
- Tag major releases

## Troubleshooting

### Can't Access Web Interface
1. Check VM is running
2. Verify network configuration
3. Try `http://[IP]:8123` directly
4. Check firewall rules

### Integration Won't Load
1. Check Home Assistant logs
2. Verify credentials in secrets.yaml
3. Ensure integration compatibility with HA version
4. Try removing and re-adding integration

### Automation Not Working
1. Check automation is enabled
2. Verify triggers and conditions
3. Test manually via Dev Tools
4. Check entity availability

### GitHub Push Fails
1. Verify SSH key is added to GitHub
2. Check git remote URL
3. Ensure files are staged
4. Check for merge conflicts

## Maintenance

### Regular Tasks
- **Weekly**: Review logs for errors
- **Monthly**: Update HA and integrations
- **Quarterly**: Review and clean automations
- **Yearly**: Full configuration review

### Backup Strategy
1. **Automated GitHub backups** (daily)
2. **HA Snapshot backups** (weekly via Google Drive Backup add-on)
3. **Full VM backups** (monthly via Proxmox)

### Update Process
1. Review release notes
2. Create backup before updating
3. Update core via Settings → System
4. Update add-ons
5. Update HACS integrations
6. Test critical automations
7. Commit changes to Git

## Resources

- [Home Assistant Documentation](https://www.home-assistant.io/docs/)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [HACS Documentation](https://hacs.xyz/docs/setup/download)
- [ESPHome Documentation](https://esphome.io/)
- [Awesome Home Assistant](https://www.awesome-ha.com/)

## Getting Help

1. Check documentation and this guide
2. Review Home Assistant logs
3. Search Community Forum
4. Ask in Discord/Reddit communities
5. Create GitHub issue for integration bugs

---

**Note**: This setup represents a mature, well-tested configuration. Start simple and add complexity gradually as you learn the platform.
