# Changelog

All notable changes to this Home Assistant configuration will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) where applicable.

## [Unreleased]

### Planned
- Additional automation documentation
- Integration optimization
- Custom dashboard configurations

## [2.0.0] - 2025-11-08

### Added
- **Comprehensive Documentation**
  - Created detailed README.md with setup overview and statistics
  - Added `docs/AUTOMATIONS.md` - Complete automation documentation
  - Added `docs/INTEGRATIONS.md` - Integration setup and configuration guide
  - Added `docs/SETUP.md` - Full installation and setup guide
  - Added this CHANGELOG.md to track configuration changes

- **Automated GitHub Backup System**
  - Created `/config/shell_scripts/github_backup.sh` backup script
  - Added automation to run backups daily at 2:00 AM
  - Added automation to backup on Home Assistant restart
  - Integrated shell_command for manual backup execution
  - Automatic commit and push to GitHub repository

- **Repository Setup**
  - Configured GitHub repository: MrBunbao/HomeAssistantConfig
  - Set up SSH authentication for automated pushes
  - Enhanced .gitignore for comprehensive security

### Changed
- **Updated README.md** - Expanded from basic placeholder to comprehensive documentation
- **Enhanced .gitignore** - Added extensive exclusions for sensitive files:
  - Database files (*.db, *.db-shm, *.db-wal)
  - Log files (*.log)
  - Certificates and keys (*.pem, *.key, *.cert)
  - Tokens and credentials
  - Backup files and zone logs
  - Custom components, themes, and other non-essential directories

### Fixed
- **Configuration YAML Syntax** - Fixed critical indentation errors in `configuration.yaml`
  - Corrected `panel_custom` section indentation
  - Fixed `ingress:` key formatting
  - Fixed `require_admin:` indentation across all panel configurations
  - Configuration now validates successfully

## [1.0.0] - 2024-10-21

### Added
- Initial Home Assistant configuration
- Core integrations setup:
  - Lutron Caseta (smart switches, dimmers, Pico remotes)
  - Philips Hue (smart lighting and sensors)
  - ESPHome devices
  - TP-Link/Kasa smart plugs
  - Wake on LAN for PC management

- **Custom Integrations (via HACS)**:
  - iCloud3 - Enhanced device tracking
  - Hue Sync Box integration
  - Meross LAN - Local device control
  - Scrypted - Camera management
  - Tapo integration
  - Extended OpenAI Conversation
  - Watchman - Entity monitoring
  - WebRTC Camera
  - Spook debugging tools
  - Sonoff LAN control
  - ResMed myAir integration

- **Automations** (19 total):
  - Office lighting control (Andy's & Shannon's offices)
  - Theater room mood lighting
  - Kitchen pantry automation with motion detection
  - Master bedroom fairy light control
  - Presence detection and arrival/departure routines
  - PC Wake on LAN integration

- **Scenes & Scripts**:
  - Lighting scenes for various rooms
  - Helper scripts for automation logic

- **Infrastructure**:
  - Running on Proxmox VM (Home Assistant OS 16.3)
  - Static IP configuration (10.10.10.5)
  - SSH access configured
  - Git version control initialized

### Security
- Implemented secrets.yaml for all sensitive data
- Configured .gitignore to exclude credentials and personal data
- SSL certificates for Lutron Caseta integration
- Secure HomeKit bridge configuration

---

## Change Categories

This changelog uses the following categories:

- **Added** - New features, integrations, or automations
- **Changed** - Changes to existing functionality
- **Deprecated** - Features that will be removed in future versions
- **Removed** - Features that have been removed
- **Fixed** - Bug fixes and corrections
- **Security** - Security-related changes

## Versioning

Version numbers follow this pattern:
- **Major** (X.0.0) - Significant configuration overhauls, Home Assistant major version updates
- **Minor** (0.X.0) - New integrations, automations, or substantial feature additions
- **Patch** (0.0.X) - Bug fixes, minor tweaks, documentation updates

---

**Note**: This changelog is maintained manually. For a complete history of all changes, see the [git commit history](https://github.com/MrBunbao/HomeAssistantConfig/commits/main).
