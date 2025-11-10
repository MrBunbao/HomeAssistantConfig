# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Important:** Proactively update this file whenever you learn something new about the repository, discover useful patterns, encounter specific quirks, or receive instructions from the user that would help future Claude instances work more effectively in this codebase.

## Overview

This is a personal Home Assistant configuration repository running on Home Assistant OS 16.3. The configuration manages smart home devices, automations, and integrations across multiple rooms and systems including Lutron Caseta, Philips Hue, Zigbee, Z-Wave, and various custom integrations.

**Key Paths:**
- Configuration root: `/homeassistant` (symlinked to `/root/config`)
- Working directory: `/root` (SSH default)
- Repository: https://github.com/MrBunbao/HomeAssistantConfig

## Quick Reference

**Most common tasks:**
```bash
cd /homeassistant              # Navigate to config directory
ha core check                  # Validate configuration before applying changes
ha core restart                # Restart Home Assistant after changes
ha core logs                   # View logs for debugging
git status                     # Check what files changed
git diff automations.yaml      # See changes in specific file
```

**When editing automations:**
1. Edit `automations.yaml` or use the UI (Settings -> Automations)
2. Run `ha core check` to validate syntax
3. Run `ha core restart` to apply changes
4. Check logs if issues occur: `ha core logs | grep -i error`

**When making configuration changes:**
1. Edit configuration files (usually `configuration.yaml`)
2. Run `ha core check` to validate
3. Run `ha core restart` to apply
4. Commit changes: `git add -u && git commit -m "Description" && git push`

## Essential Commands

### Configuration Management

**Test configuration before restarting:**
```bash
ha core check
```

**Restart Home Assistant:**
```bash
ha core restart
```

**Reload specific components without restart:**
```bash
# Use Developer Tools -> Services in the UI and call these services:
# - automation.reload
# - script.reload
# - scene.reload
# - group.reload
# - homeassistant.reload_config_entry (for integrations)
# - homeassistant.reload_core_config (for configuration.yaml changes)
# Or use the UI: Settings -> System -> (three dots) -> Reload [component]
```

**View logs:**
```bash
ha core logs
# Or view the log file directly:
tail -f /homeassistant/home-assistant.log
```

### Git & Backup Operations

**Manual backup (runs automated script):**
```bash
/config/shell_scripts/github_backup.sh
# Or via Home Assistant service:
# Developer Tools -> Services -> shell_command.github_backup
```

**Manual git workflow:**
```bash
cd /homeassistant
git status                    # Check what changed
git add -u                    # Add all tracked files
git commit -m "Description"   # Commit with message
git push origin main          # Push to GitHub
```

**Common git operations:**
```bash
cd /homeassistant
git log --oneline             # View commit history
git diff                      # See uncommitted changes
git diff --cached             # See staged changes
git checkout -- <file>        # Discard changes to file
```

### Home Assistant Supervisor Commands

```bash
ha supervisor info            # Supervisor information
ha addons                     # List installed add-ons
ha host reboot                # Reboot entire host system
ha network info               # Network configuration
```

### Debugging & Inspection Commands

**Entity inspection and debugging:**
```bash
# View all entities and their states (via Developer Tools -> States in UI)
# Or check entity details in automations:
cat /homeassistant/automations.yaml | grep "entity_id:"

# Check entity registry (UI-configured entities)
cat /homeassistant/.storage/core.entity_registry | grep -A 5 "entity_id_you_want"

# Monitor real-time events (UI: Developer Tools -> Events)
# Listen to: state_changed, automation_triggered, service_called
```

**Finding entity IDs for UI-managed devices:**
```bash
# Method 1: Search entity registry storage file
cat /homeassistant/.storage/core.entity_registry | grep -i "device_name"

# Method 2: Check device registry for device IDs
cat /homeassistant/.storage/core.device_registry | grep -i "device_name"

# Method 3: Use Developer Tools -> States in UI (most reliable)
# Filter by domain (e.g., "light.", "switch.", "sensor.")
```

**Check for automation errors:**
```bash
ha core logs | grep -i "automation"
ha core logs | grep -i "error"

# Follow logs in real-time during testing
ha core logs -f

# Check specific integration logs (e.g., iCloud3)
tail -f /homeassistant/icloud3.log
```

**Validate YAML syntax without restarting:**
```bash
ha core check
# This validates all YAML files including automations, scripts, and scenes
```

**Testing automations and services:**
```bash
# Use Developer Tools -> Services to call services manually
# Common service patterns:
# - light.turn_on (entity_id: light.example)
# - automation.trigger (entity_id: automation.example)
# - script.turn_on (entity_id: script.example)

# Check if automation is enabled:
# Developer Tools -> States -> search for automation.automation_name
# Look for state: "on" or "off"
```

### ESPHome Management

```bash
# ESPHome configurations are in /homeassistant/esphome/
ls -la /homeassistant/esphome/

# ESPHome is typically managed through the ESPHome add-on
# Access via UI: Settings -> Add-ons -> ESPHome
```

## Configuration Architecture

### File Structure

**Main Configuration Files:**
- `configuration.yaml` - Core HA config with `!include` directives and custom panel_custom sidebar entries
- `automations.yaml` - All automation definitions (19+ automations)
- `scripts.yaml` - Helper scripts for automation logic
- `scenes.yaml` - Pre-configured device states
- `secrets.yaml` - Sensitive data (never committed to git)

**Important Directories:**
- `custom_components/` - HACS custom integrations (15+ integrations, not in repo)
- `themes/` - UI themes (not in repo)
- `docs/` - Comprehensive documentation (AUTOMATIONS.md, INTEGRATIONS.md, SETUP.md, MAINTAINING.md, HOW-TO-GIT.md)
- `shell_scripts/` - Shell scripts including `github_backup.sh`
- `blueprints/` - Automation blueprints (not in repo)
- `esphome/` - ESPHome device configurations (not in repo)
- `zigbee2mqtt/` - Zigbee2MQTT configuration (not in repo)
- `www/` - Custom Lovelace resources (not in repo)
- `.storage/` - UI-configured entities, integrations, and settings (never commit)

### Configuration Pattern

This setup uses a hybrid approach:
- **Split configuration**: Main components split into separate YAML files via `!include`
- **UI-managed**: Many automations, integrations, and devices are configured through the UI (stored in `.storage/`)
- **Git-tracked**: Only essential YAML files are committed (see `.gitignore` for exclusions)

**Key include patterns:**
```yaml
automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml
frontend:
  themes: !include_dir_merge_named themes
```

### Custom Integrations (HACS)

The following custom integrations are installed via HACS:
- **iCloud3** - Enhanced iOS device tracking with zones and distance monitoring
- **Hue Sync Box** - Philips Hue Sync Box integration
- **Meross LAN** - Local control of Meross devices
- **Scrypted** - Camera and NVR integration
- **Tapo** - TP-Link Tapo devices
- **Extended OpenAI Conversation** - AI assistant with extended capabilities
- **Watchman** - Monitor missing entities/services
- **WebRTC Camera** - Real-time camera streaming
- **Spook** - Debugging and development tools
- **Sonoff LAN** - Local Sonoff device control
- **ResMed myAir** - CPAP sleep data integration
- **Xiaomi Gateway 3** - Xiaomi ecosystem devices

### Automation Patterns

Automations follow these patterns:
- **Presence-based**: Using iCloud3 device tracking with zone distance calculations
- **Event-driven**: Triggered by Lutron Pico remotes, Hue buttons, and switches
- **Motion-activated**: Pantry and area lighting using Hue motion sensors
- **Time-based**: Scheduled routines and backup operations

**Common automation structure:**
```yaml
- id: 'unique_id'
  alias: Descriptive Name
  triggers:
    - entity_id: sensor.example
      trigger: state
  conditions:
    - condition: state
      entity_id: input_boolean.flag
      state: 'on'
  actions:
    - action: light.turn_on
      target:
        entity_id: light.example
```

### Home Assistant Service Call Patterns

Service calls are the core of Home Assistant actions. Understanding the pattern is critical:

**Basic service call structure:**
```yaml
actions:
  - action: domain.service_name
    target:
      entity_id: entity.id
    data:
      parameter: value
```

**Common service domains:**
- `light.*` - Light control (turn_on, turn_off, toggle)
- `switch.*` - Switch control (turn_on, turn_off, toggle)
- `automation.*` - Automation management (trigger, turn_on, turn_off, reload)
- `script.*` - Script execution (turn_on, reload)
- `notify.*` - Notifications (send_message, persistent_notification)
- `homeassistant.*` - System services (restart, reload_config_entry)

**Light service examples:**
```yaml
# Simple turn on
- action: light.turn_on
  target:
    entity_id: light.office

# Turn on with brightness
- action: light.turn_on
  target:
    entity_id: light.office
  data:
    brightness_pct: 75

# Turn on with color
- action: light.turn_on
  target:
    entity_id: light.office
  data:
    rgb_color: [255, 0, 0]  # Red
```

**Testing service calls:**
```bash
# Use Developer Tools -> Services in UI
# 1. Select service (e.g., light.turn_on)
# 2. Choose target entity
# 3. Add data parameters in YAML mode
# 4. Click "Call Service"
```

**Key automation practices:**
- Use descriptive `alias` names for easy identification
- Include meaningful `id` values (often timestamps for uniqueness)
- Store automations in `automations.yaml` (managed by UI)
- Test automations with `ha core check` before applying
- Use template conditions for complex logic (e.g., `{{states("sensor.example") | float > 2}}`)
- Device IDs are used for Zigbee/Z-Wave devices (e.g., `device_id: 34c5a970e762b6fecf8c234195cc58fa`)

**Automation naming convention:**
- Format: `{Room Name} - {Quick General Usecase of Automation}`
- Examples:
  - `Guest Bedroom - Fan Lightbulb Toggle On/Off`
  - `Master Bedroom - Bed Frame Button for Ambient Lighting`
  - `Kitchen - Pantry Motion Activated Lighting`
- Keep names concise but descriptive enough to understand purpose at a glance

**Philips Hue effect quirk:**
- **DO NOT** use `light.toggle` with `effect` parameter - causes 400 Bad Request errors
- **DO NOT** set `brightness_pct` and `effect` together in `light.turn_on` - Hue bridge rejects this
- **CORRECT approach** for effects: Turn light on first, then apply effect in separate command
  ```yaml
  - action: light.turn_on
    target:
      entity_id: light.example
  - delay:
      milliseconds: 100
  - action: light.turn_on
    data:
      effect: fire
    target:
      entity_id: light.example
  ```

### Secrets Management

Sensitive data uses the `!secret` syntax:
```yaml
mac: !secret wakeonlan_andyspc_mac
host: !secret wakeonlan_andyspc_hostip
```

**Never commit:**
- `secrets.yaml`
- Database files (`*.db`, `*.db-shm`, `*.db-wal`)
- Log files (`*.log`)
- SSL certificates (`*.pem`, `*.key`, `*.cert`)
- Custom components directory
- `.storage/` directory

## Automated Backup System

**Automatic backups run:**
- Daily at 2:00 AM
- On Home Assistant restart

**Backup script:** `/config/shell_scripts/github_backup.sh`

**Files automatically backed up:**
- `.HA_VERSION`
- `.gitignore`
- `README.md`
- `CHANGELOG.md`
- `automations.yaml`
- `configuration.yaml`
- `scenes.yaml`
- `scripts.yaml`

The script checks for changes, commits with timestamp, and pushes to `origin/main`.

## Development Workflow

### Making Configuration Changes

1. **Edit configuration** (via UI or YAML files)
2. **Test configuration:**
   ```bash
   ha core check
   ```
3. **Reload or restart as needed**
4. **Test functionality** in Home Assistant UI
5. **Commit changes** (manual or wait for automatic backup)
6. **Update documentation** if significant changes

### Testing Changes

Before committing major changes:
```bash
# Backup current config
cp /homeassistant/configuration.yaml /homeassistant/configuration.yaml.backup

# Make changes
# ...

# Test configuration
ha core check

# If errors, restore backup:
cp /homeassistant/configuration.yaml.backup /homeassistant/configuration.yaml
```

### Rollback Procedure

**Quick rollback (specific file):**
```bash
cd /homeassistant
git log --oneline                        # Find commit hash
git checkout <commit-hash> <filename>    # Restore file
ha core restart
```

**Full rollback:**
```bash
cd /homeassistant
git reset --hard <commit-hash>           # WARNING: Loses uncommitted changes
ha core restart
```

## Common Maintenance Tasks

### Updating Documentation

When making significant changes, update:
- `CHANGELOG.md` - Add changes under `[Unreleased]` section
- `README.md` - Update integration list, statistics, or hardware info
- `docs/AUTOMATIONS.md` - Document new automations
- `docs/INTEGRATIONS.md` - Document integration changes

### Creating a CHANGELOG Entry

```markdown
## [Unreleased]

### Added
- New automation for garage door notifications

### Changed
- Updated office lighting automation timing

### Fixed
- Corrected kitchen motion sensor sensitivity
```

### Version Releases

When ready to "release" accumulated changes:
```markdown
## [2.1.0] - 2025-11-XX

### Added
- [Move items from Unreleased section]
```

**Versioning:**
- **Major (X.0.0)** - Home Assistant major version upgrade, complete restructure
- **Minor (0.X.0)** - New integrations, significant automation additions
- **Patch (0.0.X)** - Bug fixes, minor tweaks, documentation updates

### Commit Message Best Practices

**Good:**
```
Add garage door notification automation

- Sends notification when door open > 10 minutes
- Triggers at night (10pm-6am) and when away
- Includes actionable notification to close door
```

**Bad:**
```
updates
fix stuff
changes
```

## Important Notes

### Zigbee2MQTT Integration
- Configuration directory: `/homeassistant/zigbee2mqtt/`
- Managed through Zigbee2MQTT add-on (Settings -> Add-ons -> Zigbee2MQTT)
- Uses SkyConnect dongle for Zigbee communication
- Configuration not committed to repository

### Security & Privacy
- This is a **public repository** - never commit sensitive data
- All passwords, API keys, and personal info are in `secrets.yaml` (gitignored)
- IP addresses and MAC addresses are excluded from commits
- Database and log files are gitignored

### UI vs YAML Configuration
- Many automations and integrations are **UI-managed** (stored in `.storage/` directory)
- UI-managed items won't appear in YAML files but are functional
- Some automations may reference entities not visible in committed config files

### SSH Access
- Host: `10.10.10.5` or `homeassistant.local`
- User: `root`
- SSH key authentication configured for GitHub pushes

### Platform Specifics
- **Installation Type:** Home Assistant OS (qemux86-64) on Proxmox VM
- **Python environment:** Managed by Home Assistant OS (no manual Python package installation)
- **Add-ons:** Managed through Supervisor, not pip/apt

### Working with Custom Integrations (HACS)
- HACS is installed and manages 15+ custom integrations
- Custom integrations are in `/homeassistant/custom_components/`
- **Never commit custom_components/** - these are managed by HACS

**Updating HACS integrations:**
```bash
# Update through HACS UI: Settings -> HACS
# 1. Click on integration to update
# 2. Click "Download" or "Update"
# 3. Restart Home Assistant after updates
ha core restart

# Check HACS logs for update issues:
ha core logs | grep -i "hacs"
```

**After updating custom integrations:**
```bash
# Always restart Home Assistant
ha core restart

# Check if integration loaded successfully
ha core logs | grep -i "custom_components"
ha core logs | grep -i "integration_name"

# Custom integration logs appear in:
# - ha core logs (general)
# - /homeassistant/icloud3.log (for iCloud3 specifically)
```

**Troubleshooting HACS integrations:**
```bash
# If integration fails to load after update:
# 1. Check logs for specific errors
ha core logs | grep -i "error" | grep -i "custom_components"

# 2. Clear cache and restart
rm -rf /homeassistant/.storage/custom_components.json
ha core restart

# 3. Reinstall integration through HACS if needed
# HACS -> Integration -> Remove -> Reinstall
```

## Common Troubleshooting Workflows

### Automation Not Triggering

1. **Verify automation is enabled:**
   ```bash
   # Check state in Developer Tools -> States
   # Search for: automation.automation_name
   # State should be "on"
   ```

2. **Check automation syntax:**
   ```bash
   ha core check
   ha core logs | grep -i "automation_name"
   ```

3. **Test trigger manually:**
   ```bash
   # Developer Tools -> Services
   # Call: automation.trigger
   # Entity: automation.automation_name
   ```

4. **Monitor events in real-time:**
   ```bash
   # Developer Tools -> Events -> Listen to: state_changed
   # Change the trigger entity state and see if event fires
   ```

### Light/Device Not Responding

1. **Check entity state:**
   ```bash
   # Developer Tools -> States
   # Find entity and check if "unavailable"
   ```

2. **Test service call manually:**
   ```bash
   # Developer Tools -> Services
   # Try: light.turn_on with entity_id
   # Check for error messages
   ```

3. **Check integration logs:**
   ```bash
   ha core logs | grep -i "integration_name"
   ha core logs | grep -i "entity_id"
   ```

4. **Reload integration:**
   ```bash
   # Settings -> Devices & Services -> Integration -> (three dots) -> Reload
   # Or restart: ha core restart
   ```

### Configuration Not Loading After Changes

1. **Validate YAML syntax:**
   ```bash
   ha core check
   # Fix any errors reported
   ```

2. **Check for indentation issues:**
   ```bash
   # YAML is indentation-sensitive (use 2 spaces, not tabs)
   cat /homeassistant/configuration.yaml
   ```

3. **Reload specific component:**
   ```bash
   # Developer Tools -> Services
   # Call appropriate reload service (e.g., script.reload)
   ```

4. **Check logs for load errors:**
   ```bash
   ha core restart
   ha core logs | grep -i "error"
   ```

### Git Push Failures

1. **Check SSH authentication:**
   ```bash
   cd /homeassistant
   git remote -v  # Verify remote URL uses SSH
   ssh -T git@github.com  # Test SSH connection
   ```

2. **Pull latest changes first:**
   ```bash
   git pull origin main
   # Resolve any merge conflicts
   git push origin main
   ```

3. **Check backup script logs:**
   ```bash
   # If using automated backup, check for error messages
   /config/shell_scripts/github_backup.sh
   ```

## Reference Documentation

Comprehensive guides in `docs/` folder:
- **HOW-TO-GIT.md** - Detailed git workflow and backup procedures
- **AUTOMATIONS.md** - Automation documentation and examples
- **INTEGRATIONS.md** - Integration setup guides
- **SETUP.md** - Installation and setup instructions
- **MAINTAINING.md** - Maintenance procedures and best practices

Also see:
- **CHANGELOG.md** - Version history
- **README.md** - Setup overview and statistics
