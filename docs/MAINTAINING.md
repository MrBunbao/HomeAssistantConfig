# Maintaining Your Configuration

Guide for keeping your Home Assistant configuration up-to-date and well-documented.

## Updating the CHANGELOG

The `CHANGELOG.md` file should be updated whenever you make significant changes to your configuration.

### When to Update

Update the CHANGELOG when you:
- Add new integrations
- Create significant automations
- Remove or deprecate features
- Fix important bugs
- Update Home Assistant to a new major version
- Make security-related changes

### How to Update

1. **Edit CHANGELOG.md**
   ```bash
   # SSH into Home Assistant or use File Editor
   nano /homeassistant/CHANGELOG.md
   ```

2. **Add your changes under [Unreleased]**
   ```markdown
   ## [Unreleased]
   
   ### Added
   - New integration for XYZ device
   - Automation for automated lighting in garage
   
   ### Changed
   - Updated Hue configuration to use new bridge
   
   ### Fixed
   - Corrected automation trigger for morning routine
   ```

3. **When ready to "release" (create a version)**
   - Move items from [Unreleased] to a new version section
   - Use semantic versioning: `[Major.Minor.Patch] - YYYY-MM-DD`
   - Example:
   ```markdown
   ## [2.1.0] - 2025-11-15
   
   ### Added
   - New integration for XYZ device
   ```

### Change Categories

Use these standard categories:

- **Added** - New features, integrations, or automations
- **Changed** - Changes to existing functionality  
- **Deprecated** - Features that will be removed soon
- **Removed** - Features that have been removed
- **Fixed** - Bug fixes and corrections
- **Security** - Security-related changes

### Versioning Guide

**Major (X.0.0)** - Use when:
- Upgrading Home Assistant major version (e.g., 2024.x to 2025.x)
- Complete configuration restructure
- Breaking changes that affect many automations

**Minor (0.X.0)** - Use when:
- Adding new integrations
- Creating new automation groups
- Adding significant features
- Removing integrations

**Patch (0.0.X)** - Use when:
- Fixing bugs
- Updating documentation
- Minor automation tweaks
- Small configuration changes

## Git Best Practices

### Manual Commits

When making manual commits (outside of automatic backups):

```bash
cd /homeassistant

# Check what changed
git status

# Add specific files
git add configuration.yaml automations.yaml

# Or add all tracked files
git add -u

# Commit with descriptive message
git commit -m "Add automation for garage door notifications"

# Push to GitHub
git push origin main
```

### Writing Good Commit Messages

**Good commit messages:**
```
Add Zigbee temperature sensors to bedroom

- Integrated 3 Aqara temperature sensors
- Created automation for HVAC control based on bedroom temp
- Added sensors to Lovelace dashboard
```

**Bad commit messages:**
```
updates
fix stuff
changes
```

### Commit Message Format

```
Short summary (50 chars or less)

Longer explanation of what changed and why. Wrap at 72 characters.
Include bullet points if multiple changes:

- First change
- Second change  
- Third change

Reference issues if applicable: Fixes #123
```

## Automated Backups

Your configuration automatically backs up to GitHub:
- **Daily** at 2:00 AM
- **On Home Assistant restart**

### Check Backup Status

View automation status:
1. Settings → Automations & Scenes
2. Find "GitHub Configuration Backup"
3. Check last triggered time
4. Review history

### Manual Backup

Trigger a manual backup:

**Via UI:**
1. Developer Tools → Services
2. Service: `shell_command.github_backup`
3. Call Service

**Via Command Line:**
```bash
ssh root@homeassistant.local
/config/shell_scripts/github_backup.sh
```

### Backup Script Location

Script: `/config/shell_scripts/github_backup.sh`

Files automatically backed up:
- `.HA_VERSION`
- `.gitignore`
- `README.md`
- `CHANGELOG.md`
- `automations.yaml`
- `configuration.yaml`
- `scenes.yaml`
- `scripts.yaml`

## Documentation Updates

### When to Update Documentation

**README.md** - Update when:
- Adding/removing integrations
- Changing infrastructure
- Updating HA version
- Adding significant automations

**docs/AUTOMATIONS.md** - Update when:
- Creating new automations
- Modifying automation behavior
- Adding automation categories

**docs/INTEGRATIONS.md** - Update when:
- Adding custom integrations
- Changing integration configurations
- Discovering integration tips/tricks

**docs/SETUP.md** - Update when:
- Changing setup process
- Adding prerequisites
- Updating installation steps

### Documentation Tips

1. **Be specific** - Include exact steps and commands
2. **Add examples** - Show configuration snippets
3. **Explain why** - Not just what, but why you did it
4. **Keep current** - Remove outdated information
5. **Link references** - Include URLs to official docs

## Maintenance Schedule

### Daily (Automated)
- ✅ GitHub backup runs at 2:00 AM

### Weekly
- Review Home Assistant logs for errors
- Check automation execution history
- Verify backup automation ran successfully

### Monthly  
- Update Home Assistant core
- Update HACS integrations
- Review and clean up unused entities
- Update CHANGELOG with month's changes
- Review documentation for accuracy

### Quarterly
- Full configuration review
- Security audit (check secrets, certificates)
- Test critical automations
- Review and optimize automations
- Create "release" in CHANGELOG

### Yearly
- Major documentation update
- Archive old logs and backups
- Review all integrations for alternatives
- Clean up unused custom components

## Testing Changes

Before committing major changes:

1. **Backup Current Config**
   ```bash
   cp configuration.yaml configuration.yaml.backup
   ```

2. **Test Configuration**
   ```bash
   ha core check
   ```

3. **Test in Development**
   - Make changes
   - Reload automations/scripts
   - Test functionality
   - Monitor logs

4. **Commit Only When Working**
   ```bash
   git add configuration.yaml
   git commit -m "Add new feature (tested)"
   git push
   ```

## Rollback Procedure

If something breaks:

### Quick Rollback (Recent Change)
```bash
cd /homeassistant
git log --oneline  # Find commit to revert to
git checkout abc123 configuration.yaml  # Restore specific file
ha core restart
```

### Full Rollback
```bash
cd /homeassistant  
git log --oneline  # Find good commit
git reset --hard abc123  # WARNING: Loses uncommitted changes
ha core restart
```

### Restore from GitHub
```bash
cd /homeassistant
git fetch origin
git reset --hard origin/main
ha core restart
```

## Home Assistant Updates

### Before Updating

1. **Check Release Notes**
   - Breaking changes?
   - Deprecated features?
   - New requirements?

2. **Create Backup**
   - Settings → System → Backups → Create Backup
   - Or use Google Drive Backup add-on

3. **Test in Staging** (if available)
   - Update test instance first
   - Verify automations work

### Update Process

1. Settings → System → Updates
2. Review changelog
3. Click "Update"
4. Wait for restart
5. Test critical automations
6. Check logs for errors

### After Updating

1. **Update CHANGELOG.md**
   ```markdown
   ## [2.1.0] - 2025-11-XX
   
   ### Changed
   - Updated Home Assistant Core to 2025.12.0
   - Updated integration XYZ to version 1.2.3
   ```

2. **Update README.md**
   ```markdown
   - **Home Assistant Core Version:** 2025.12.0
   ```

3. **Commit Changes**
   ```bash
   git add CHANGELOG.md README.md .HA_VERSION
   git commit -m "Update Home Assistant to 2025.12.0"
   git push
   ```

## Tips for Success

1. **Commit Often** - Small, frequent commits are better than large ones
2. **Test First** - Always test before committing
3. **Document Everything** - Future you will thank present you
4. **Use Branches** - For experimental features (advanced)
5. **Keep Secrets Secret** - Never commit secrets.yaml
6. **Monitor Backups** - Ensure they're running
7. **Stay Updated** - Regular updates = fewer issues

## Getting Help

If you need assistance:

1. **Check Documentation** - docs/ folder and README.md
2. **Review Logs** - Settings → System → Logs
3. **Search Community** - community.home-assistant.io
4. **GitHub Issues** - Check integration repositories
5. **Discord/Reddit** - Active communities available

---

**Remember**: Good documentation and version control practices make Home Assistant administration much easier. Take the time to document changes as you make them!
