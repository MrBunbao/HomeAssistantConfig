# Integration Documentation

Detailed information about the integrations used in this Home Assistant setup.

## Core Integrations

### Lutron Caseta
**Purpose**: Smart lighting control and automation

**Devices**:
- Smart dimmers and switches
- Pico wireless remotes
- Caseta bridge/hub

**Configuration**:
- Bridge discovered automatically via mDNS
- SSL certificates stored in config directory
- Certificates format: `lutron_caseta-[ID]-{ca,cert,key}.pem`

**Use Cases**:
- Whole-home lighting control
- Scene activation via Pico remotes
- Integration with voice assistants

**Documentation**: https://www.home-assistant.io/integrations/lutron_caseta/

### Philips Hue
**Purpose**: Smart lighting and sensors

**Devices**:
- Hue bulbs and light strips
- Hue motion sensors
- Hue dimmer switches
- Hue buttons (4-button controllers)

**Features**:
- Motion-activated lighting
- Manual button control
- Brightness adjustment
- Color temperature control

**Documentation**: https://www.home-assistant.io/integrations/hue/

### ESPHome
**Purpose**: Custom ESP32/ESP8266 devices

**Known Devices**:
- M5Stack Atom Echo (voice control)
- Bed presence sensor
- Custom sensors and controllers

**Features**:
- Real-time updates
- Local control (no cloud)
- Custom device creation

**Documentation**: https://esphome.io/

### TP-Link Kasa
**Purpose**: Smart plugs and switches

**Devices**:
- Smart plugs with energy monitoring
- Control via local network
- Power measurement capabilities

**Integration**: Both cloud and local modes supported

**Documentation**: https://www.home-assistant.io/integrations/tplink/

## Custom Integrations (HACS)

### iCloud3
**Repository**: https://github.com/gcobb321/icloud3

**Purpose**: Enhanced iOS device tracking

**Features**:
- Accurate location tracking
- Zone distance calculations
- Driving detection
- Battery monitoring
- Configurable update intervals

**Configuration**:
- Uses iCloud credentials (in secrets)
- Tracks multiple devices
- Custom zone definitions

**Why iCloud3**: Superior to native iCloud integration with more features and better accuracy

### HACS (Home Assistant Community Store)
**Repository**: https://hacs.xyz/

**Purpose**: Custom integration and frontend management

**Features**:
- Easy installation of custom integrations
- Frontend themes and cards
- Automatic update notifications

**Installed Custom Integrations**:
- iCloud3
- Hue Sync Box
- Meross LAN
- Scrypted
- Tapo
- Extended OpenAI Conversation
- Watchman
- WebRTC
- Spook
- Sonoff LAN
- ResMed myAir

### Extended OpenAI Conversation
**Repository**: https://github.com/jekalmin/extended_openai_conversation

**Purpose**: Advanced AI assistant with extended capabilities

**Features**:
- Natural language control
- Complex query handling
- Integration with OpenAI API
- Custom functions and tools

**Use Cases**:
- Voice control
- Complex automation triggers
- Information queries

### Watchman
**Repository**: https://github.com/dummylabs/thewatchman

**Purpose**: Monitor missing entities and services

**Features**:
- Detects broken automations
- Identifies missing entities
- Reports unavailable devices
- Regular health checks

**Output**: Generates `watchman_report.txt`

### Scrypted
**Website**: https://www.scrypted.app/

**Purpose**: Camera management and NVR functionality

**Features**:
- Camera integration
- Video streaming
- Recording management
- HomeKit Secure Video support

### WebRTC Camera
**Repository**: https://github.com/AlexxIT/WebRTC

**Purpose**: Real-time camera streaming

**Features**:
- Low-latency video
- Works with various camera brands
- Browser-based viewing
- No transcoding required

### Meross LAN
**Repository**: https://github.com/krahabb/meross_lan

**Purpose**: Local control of Meross devices

**Features**:
- No cloud dependency
- Faster response times
- Privacy-focused
- Supports various Meross devices

### Tapo Integration
**Repository**: https://github.com/petretiandrea/home-assistant-tapo-p100

**Purpose**: TP-Link Tapo device control

**Devices**:
- Tapo smart plugs
- Tapo cameras
- Tapo bulbs

**Features**:
- Local network control
- Energy monitoring
- Device scheduling

### Spook
**Repository**: https://github.com/frenck/spook

**Purpose**: Debugging and development tools

**Features**:
- Advanced entity management
- Service testing
- Developer utilities
- Experimental features

**Use Case**: Development and troubleshooting

### Hue Sync Box
**Repository**: https://github.com/mvdwetering/huesyncbox

**Purpose**: Control Philips Hue Sync Box

**Features**:
- Sync mode control
- HDMI input selection
- Brightness and intensity control
- Entertainment area management

### ResMed myAir
**Repository**: https://github.com/prestomation/homeassistant-resmed

**Purpose**: CPAP sleep therapy data

**Features**:
- Sleep score tracking
- Usage hours monitoring
- AHI (Apnea-Hypopnea Index) data
- Mask fit information

**Privacy**: Credentials stored in secrets.yaml

## Native Integrations

### Wake on LAN
**Purpose**: Remote PC power management

**Configuration**:
```yaml
switch:
  - platform: wake_on_lan
    mac: !secret wakeonlan_andyspc_mac
    host: !secret wakeonlan_andyspc_hostip
    name: "AndyHomePC"
```

**Use Cases**:
- Remote desktop power-on
- Automation-triggered PC startup
- Integration with presence detection

### Zigbee2MQTT
**Purpose**: Zigbee device integration

**Features**:
- Wide device compatibility
- Local control
- No proprietary hubs needed
- MQTT-based communication

### Z-Wave JS
**Purpose**: Z-Wave device management

**Features**:
- Secure Z-Wave communication
- Device pairing and management
- Network healing
- OTA firmware updates

**Backup**: Z-Wave network backups stored as `.bin` files

### HomeKit
**Purpose**: iOS integration and HomeKit bridge

**Features**:
- Expose HA devices to HomeKit
- Siri control
- iOS shortcuts integration
- Secure communication

**Configuration**: Multiple HomeKit bridges for different device groups

### Nest
**Purpose**: Nest device integration

**Devices**:
- Nest thermostats
- Nest cameras
- Nest Protect

**Features**:
- Climate control
- Camera streaming
- Smoke/CO detection

## Integration Best Practices

1. **Keep integrations updated** via HACS and HA updates
2. **Use secrets.yaml** for all credentials
3. **Local control preferred** over cloud when possible
4. **Monitor entity availability** with Watchman
5. **Document custom configurations** in this file
6. **Regular backups** of integration configs

## Troubleshooting

### Integration Not Loading
1. Check Home Assistant logs
2. Verify credentials in secrets.yaml
3. Ensure integration version compatibility
4. Restart Home Assistant

### Device Not Discovered
1. Check network connectivity
2. Verify device is powered on
3. Review integration documentation
4. Check firewall settings

### HACS Issues
1. Clear browser cache
2. Restart Home Assistant
3. Re-download integration
4. Check GitHub rate limits

---

For automation examples using these integrations, see [AUTOMATIONS.md](AUTOMATIONS.md)
