# Home Assistant Configuration

My personal [Home Assistant](https://www.home-assistant.io/) setup, running on Home Assistant OS 16.3.

## 📊 Statistics

- **Home Assistant Core Version:** 2025.11.1
- **Automations:** 19
- **Scripts:** Multiple helper scripts for automation logic
- **Scenes:** Pre-configured lighting and device states
- **Custom Integrations:** 14+

## 🏠 Hardware & Infrastructure

### Host System
- **Platform:** Home Assistant OS 16.3 (qemux86-64)
- **Installation Type:** Virtual Machine on Proxmox
- **IP Address:** 10.10.10.5

### Smart Home Hubs & Bridges
- **Lutron Caseta Bridge** - Smart lighting control and Pico remotes
- **Philips Hue Bridge** - Hue lights and sensors
- **Nabu Casa SkyConnect** - Zigbee/Thread radio (OpenThread Border Router)
- **Xiaomi Gateway 3** - Xiaomi ecosystem devices

## 🔌 Integrations

### Native Integrations
- **Lutron Caseta** - Smart switches, dimmers, and Pico remotes
- **Philips Hue** - Smart lighting and motion sensors
- **ESPHome** - Custom ESP32/ESP8266 devices
- **TP-Link/Kasa** - Smart plugs and switches
- **Wake on LAN** - PC power management
- **Zigbee2MQTT** - Zigbee device integration
- **Z-Wave JS** - Z-Wave device management
- **iCloud** - iOS device tracking
- **Nest** - Nest thermostat/camera integration
- **HomeKit** - HomeKit bridge for iOS integration

### Custom Integrations (via HACS)
- **[HACS](https://hacs.xyz/)** - Home Assistant Community Store
- **[iCloud3](https://github.com/gcobb321/icloud3)** - Enhanced iCloud device tracking
- **[Hue Sync Box](https://github.com/mvdwetering/huesyncbox)** - Philips Hue Sync Box integration
- **[Meross LAN](https://github.com/krahabb/meross_lan)** - Local Meross device control
- **[Scrypted](https://www.scrypted.app/)** - Camera and NVR integration
- **[Tapo](https://github.com/petretiandrea/home-assistant-tapo-p100)** - TP-Link Tapo device integration
- **[Extended OpenAI Conversation](https://github.com/jekalmin/extended_openai_conversation)** - Advanced AI assistant integration
- **[Watchman](https://github.com/dummylabs/thewatchman)** - Monitor missing entities and services
- **[WebRTC Camera](https://github.com/AlexxIT/WebRTC)** - Real-time camera streaming
- **[Spook](https://github.com/frenck/spook)** - Debugging and development tools
- **[Sonoff LAN](https://github.com/AlexxIT/SonoffLAN)** - Local Sonoff device control
- **[ResMed myAir](https://github.com/prestomation/homeassistant-resmed)** - CPAP sleep data integration

## 📱 Devices & Automation Highlights

### Smart Lighting
- Lutron Caseta switches and dimmers throughout the home
- Philips Hue bulbs and light strips
- Pico remote controls for scenes and automation triggers
- Hue motion sensors for automatic lighting

### Office Automation
- **Andy's Office** - Automated lighting with Pico remote control, pegboard accent lighting
- **Shannon's Office** - Pico remote-controlled lighting
- Wake on LAN for desktop PC

### Room-Specific Features
- **Theater Room** - Lutron-controlled mood lighting with switch automation
- **Kitchen** - Pantry lighting automation with Hue button controls and motion detection
- **Master Bedroom** - Hue dimmer switch for fairy light control

### Presence Detection
- iCloud3 device tracking for household members
- Zone-based automation triggers
- Distance-based arrival/departure detection

## 🤖 Automation Examples

This configuration includes automations for:
- **Lighting scenes** triggered by Pico remotes and switches
- **Motion-activated lighting** in pantries and common areas
- **Brightness control** with up/down button automation
- **Arrival/departure routines** based on presence detection
- **Power management** for PCs and entertainment systems

See the [docs/](docs/) folder for detailed automation documentation.

## 🛠️ Configuration Structure

```
.
├── configuration.yaml          # Main configuration file
├── automations.yaml           # All automation definitions
├── scripts.yaml              # Helper scripts
├── scenes.yaml               # Lighting and device scenes
├── secrets.yaml              # Sensitive data (not in repo)
├── custom_components/        # Custom integrations (not in repo)
├── themes/                   # UI themes (not in repo)
└── docs/                     # Documentation and guides
```

## 🔒 Security & Privacy

Sensitive information is stored in `secrets.yaml` and referenced using `!secret` tags. The following are **NOT** included in this repository:
- Passwords and API keys
- IP addresses and MAC addresses
- SSL certificates and private keys
- Database files
- Log files
- Personal location data

## 📝 Notes

- This is a **public repository** for portfolio and reference purposes
- Configuration is actively maintained and updated
- Automated backups push changes to GitHub regularly
- Some automations may reference devices not visible in the config (managed through UI)

## 🔄 Automatic Backups

This repository is automatically backed up via a Home Assistant automation that:
- Commits configuration changes daily
- Pushes to GitHub when changes are detected
- Maintains version history for rollback capability

## 📚 Resources

- [Home Assistant Documentation](https://www.home-assistant.io/docs/)
- [Home Assistant Community](https://community.home-assistant.io/)
- [HACS - Home Assistant Community Store](https://hacs.xyz/)

---

**Generated and maintained with [Claude Code](https://claude.com/claude-code)**
