# How to Push Changes to GitHub

Simple guide for manually pushing your Home Assistant configuration changes to GitHub.

## Quick Answer

**Will it push automatically?** 
✅ **YES** - Your configuration automatically backs up:
- Every day at 2:00 AM
- When Home Assistant restarts

**Do I need to do anything manually?**
❌ **NO** - For most changes, just wait for the automatic backup.

✅ **YES** - Only if you want to push changes **immediately** with a custom message.

---

## When to Push Manually

Push manually when you:
- Made important changes and want to save them **right now**
- Want to add a **descriptive commit message** explaining what you did
- Just finished a major configuration update
- Want to ensure changes are backed up before testing something risky

**Otherwise, just let the automatic backup handle it!**

---

## Method 1: Simple One-Command Push (Easiest)

Just run the backup script manually:

### From Home Assistant Terminal (SSH)

```bash
# SSH into Home Assistant
ssh root@10.10.10.5

# Run the backup script
/config/shell_scripts/github_backup.sh
```

**That's it!** The script will:
- ✅ Check for changes
- ✅ Commit them with a timestamp
- ✅ Push to GitHub

### From Home Assistant UI

1. Go to **Developer Tools** → **Services**
2. Service: `shell_command.github_backup`
3. Click **"Call Service"**
4. Done! ✅

---

## Method 2: Manual Git Commands (More Control)

Use this when you want to write your own commit message.

### Step 1: SSH into Home Assistant

```bash
ssh root@10.10.10.5
```

### Step 2: Navigate to Config Directory

```bash
cd /homeassistant
```

### Step 3: Check What Changed

```bash
git status
```

You'll see something like:
```
Changes not staged for commit:
  modified:   automations.yaml
  modified:   configuration.yaml
```

### Step 4: Add Files You Want to Commit

**Add specific files:**
```bash
git add automations.yaml configuration.yaml
```

**Or add all tracked files:**
```bash
git add -u
```

### Step 5: Commit with Your Message

```bash
git commit -m "Your description of what changed"
```

**Examples of good messages:**
```bash
git commit -m "Add garage door notification automation"
git commit -m "Update bedroom lighting scenes"
git commit -m "Fix kitchen motion sensor automation timing"
git commit -m "Add Ecobee thermostat integration"
```

### Step 6: Push to GitHub

```bash
git push origin main
```

### Complete Example

```bash
# SSH in
ssh root@10.10.10.5

# Navigate to config
cd /homeassistant

# Check what changed
git status

# Add your changes
git add automations.yaml configuration.yaml

# Commit with message
git commit -m "Add garage door automation with notifications"

# Push to GitHub
git push origin main

# Done!
```

---

## Method 3: All-in-One Command

Combine everything into one command (from your local machine):

```bash
ssh root@10.10.10.5 "cd /homeassistant && git add -u && git commit -m 'Quick update' && git push origin main"
```

---

## Common Scenarios

### Scenario 1: Just Created a New Automation

**Option A - Let it backup automatically:**
- Do nothing, wait for 2 AM backup ✅

**Option B - Push immediately:**
```bash
ssh root@10.10.10.5
cd /homeassistant
git add automations.yaml
git commit -m "Add new automation for outdoor lights"
git push origin main
```

### Scenario 2: Modified Several Files

```bash
ssh root@10.10.10.5
cd /homeassistant
git add automations.yaml configuration.yaml scripts.yaml
git commit -m "Update lighting configuration and add new scripts"
git push origin main
```

### Scenario 3: Want to Update CHANGELOG Too

```bash
ssh root@10.10.10.5
cd /homeassistant

# Edit CHANGELOG first (use File Editor in HA UI or nano)
nano CHANGELOG.md
# Add your changes under [Unreleased]
# Save and exit (Ctrl+X, Y, Enter)

# Then commit everything
git add CHANGELOG.md automations.yaml
git commit -m "Add garage automation and update CHANGELOG"
git push origin main
```

### Scenario 4: Just Want to Save Everything Now

```bash
ssh root@10.10.10.5
/config/shell_scripts/github_backup.sh
```

**Simplest option!** ✅

---

## Checking If Changes Were Pushed

### Check Git Status
```bash
ssh root@10.10.10.5
cd /homeassistant
git status
```

If you see:
```
On branch main
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```
✅ **Everything is backed up!**

### Check on GitHub
1. Go to https://github.com/MrBunbao/HomeAssistantConfig
2. Look at recent commits
3. Check the timestamp

### Check Last Backup Time
1. Settings → Automations & Scenes
2. Find "GitHub Configuration Backup"
3. Check "Last Triggered" time

---

## Troubleshooting

### "Nothing to commit, working tree clean"
✅ **This is good!** It means everything is already backed up.

### "Your branch is ahead of origin/main"
You have local commits that haven't been pushed yet.

**Fix:**
```bash
cd /homeassistant
git push origin main
```

### "Your branch and origin/main have diverged"
Changes were made on GitHub that aren't in your local copy.

**Fix:**
```bash
cd /homeassistant
git pull origin main --no-edit
git push origin main
```

### Permission Denied
SSH key might have issues.

**Fix:**
```bash
ssh -T git@github.com
# Should say: "Hi MrBunbao! You've successfully authenticated"
```

If not, the SSH key needs to be re-added to GitHub.

### Changes Not Showing Up
Make sure you added the files:

```bash
cd /homeassistant
git status  # See what's changed
git add filename.yaml  # Add the file
git commit -m "message"
git push origin main
```

---

## Best Practices

### ✅ DO:
- Write descriptive commit messages
- Push after major changes
- Update CHANGELOG for significant changes
- Test configuration before committing (`ha core check`)
- Let automatic backups handle routine changes

### ❌ DON'T:
- Commit every tiny change manually (let auto-backup handle it)
- Use vague messages like "update" or "fix"
- Forget to add files before committing
- Push without testing configuration first

---

## Quick Reference Card

| What I Want to Do | Command |
|-------------------|---------|
| **Quick backup NOW** | `ssh root@10.10.10.5 /config/shell_scripts/github_backup.sh` |
| **Check what changed** | `cd /homeassistant && git status` |
| **Add specific file** | `git add filename.yaml` |
| **Add all changes** | `git add -u` |
| **Commit changes** | `git commit -m "Your message"` |
| **Push to GitHub** | `git push origin main` |
| **See commit history** | `git log --oneline` |
| **Undo last commit** | `git reset --soft HEAD~1` |

---

## Example Workflow

Here's a real-world example:

```bash
# 1. You just added a new automation in the HA UI
# 2. You want to back it up immediately with a good description

# SSH in
ssh root@10.10.10.5

# Go to config directory
cd /homeassistant

# Check what changed
git status
# Shows: modified: automations.yaml

# Add the file
git add automations.yaml

# Update the CHANGELOG (optional but recommended)
nano CHANGELOG.md
# Add under [Unreleased]:
# ### Added
# - Garage door notification automation
# Save and exit

# Add CHANGELOG too
git add CHANGELOG.md

# Commit with descriptive message
git commit -m "Add garage door notification automation

- Sends notification when door is left open > 10 minutes
- Triggers at night (10pm-6am) and when away from home
- Includes actionable notification to close door"

# Push to GitHub
git push origin main

# Done! Your changes are backed up with a nice description
```

---

## Summary

**For 95% of changes:** 
Just make your changes in Home Assistant and forget about it. The automatic backup at 2 AM will handle it! ✅

**For important changes you want saved immediately:**
```bash
ssh root@10.10.10.5
/config/shell_scripts/github_backup.sh
```

**For changes you want to document properly:**
Use Method 2 (Manual Git Commands) with a descriptive commit message.

---

**Remember:** The automatic backup is your safety net. Manual pushes are just for when you want more control or immediate backup!
