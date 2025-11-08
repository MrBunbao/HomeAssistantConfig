# Automation Documentation

This document describes the key automations in this Home Assistant configuration.

## Lighting Automations

### Office Lighting Control

#### Andy's Office
**Pico Remote Control**
- **ON Button**: Activates office lighting scene
- **OFF Button**: Turns off all office lights
- **Brightness UP**: Increases light brightness incrementally
- **Brightness DOWN**: Decreases light brightness incrementally
- **Center Button**: Toggles pegboard accent lighting

**Devices**: Lutron Pico Remote, Lutron dimmers/switches

#### Shannon's Office
**Pico Remote Control**
- **ON Button**: Activates office lighting
- **OFF Button**: Turns off office lights

**Devices**: Lutron Pico Remote, Lutron switches

### Theater Room
**Lutron Table Switch Automation**
- **ON**: Activates theater mood lighting scene
- **OFF**: Turns off mood lighting

**Devices**: Lutron switch, various lighting devices

### Kitchen Automation

#### Pantry Lighting
**Motion-Activated Lighting**
- Hue motion sensor detects presence
- Automatically turns on pantry lights
- Configurable timeout for auto-off

**Hue Button Control (4-button)**
- **Button 1**: Toggle pantry lights
- **Button 2 (UP)**: Increase brightness
- **Button 3 (DOWN)**: Decrease brightness
- **Button 4**: Special scene/mode

**Devices**: Hue motion sensor, Hue button, Hue lights

### Master Bedroom

#### Fairy Lights Control
**Hue Dimmer Switch**
- **ON Button**: Turn on fairy lights
- **OFF Button**: Turn off fairy lights
- **Toggle Function**: Alternate on/off states

**Devices**: Hue dimmer switch, fairy light smart plugs

## Presence Detection Automations

### Andy - Driving Flag
**Purpose**: Detects when Andy arrives home and updates driving status

**Triggers**:
- Device tracker state changes to "home"
- 5-minute delay to confirm arrival

**Actions**:
- Turns off "driving" boolean flag
- Can trigger arrival routines

**Integration**: iCloud3 device tracking

### Arrival/Departure Detection
- Zone distance calculations using iCloud3
- Automated notifications for arrivals
- Distance-based triggers (within 0.10 units of home)

## System Automations

### GitHub Configuration Backup
**Purpose**: Automatically backup configuration to GitHub repository

**Triggers**:
- Daily at 2:00 AM
- On Home Assistant restart

**Actions**:
- Checks for configuration changes
- Commits changes with timestamp
- Pushes to GitHub repository

**Files Backed Up**:
- configuration.yaml
- automations.yaml
- scripts.yaml
- scenes.yaml
- .gitignore
- README.md

## Wake on LAN

### PC Power Management
**Device**: AndyHomePC

**Functionality**:
- Remote wake capability via network
- Integration with presence detection
- Can be triggered by automations or manually

**Configuration**: Uses MAC address and host IP from secrets

## Notes on Automation Structure

- All automations use unique IDs for tracking
- Most automations include descriptions for documentation
- Automations reference devices that may be managed through the UI
- Some device IDs are hashed for privacy in the repository

## Creating New Automations

When creating new automations:
1. Use descriptive aliases
2. Include descriptions explaining purpose
3. Consider fail-safes and conditions
4. Test thoroughly before deployment
5. Document in this file if significant

## Troubleshooting

**Automation Not Triggering**:
- Check entity/device availability
- Verify conditions are met
- Review Home Assistant logs
- Ensure integrations are loaded

**Device Not Responding**:
- Check device connection
- Verify integration status
- Review device configuration
- Check for firmware updates

---

For more details on specific integrations, see [INTEGRATIONS.md](INTEGRATIONS.md)
