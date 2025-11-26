# Claude Code Persistent Installation Guide

## Problem
Home Assistant OS runs in a Docker container with an overlay filesystem. The root filesystem (`/`) is ephemeral and gets reset on container restart, causing Claude Code installations in `/root/.local` to disappear.

## Solution
Claude Code has been configured to persist across container restarts by:

1. **Installing to persistent storage**: `/data/.local/` (mounted from `/dev/sda8`)
2. **Symlinking shell configuration files** to persistent storage
3. **Modifying PATH** to prioritize the persistent installation

## Current Setup

### Installation Location
- Binary: `/data/.local/share/claude/versions/2.0.37`
- Symlink: `/data/.local/bin/claude -> /data/.local/share/claude/versions/2.0.37`

### Persistent Shell Configuration
- `/root/.zshrc` → symlink to `/data/.zshrc`
- `/root/.zprofile` → symlink to `/data/.zprofile`

### PATH Configuration
`/data/.zprofile` includes:
```zsh
export PATH="/data/.local/bin:$PATH"
```

This ensures `/data/.local/bin` is added to PATH before other directories, making the persistent `claude` command available.

## Verification

Test that Claude Code is accessible:
```bash
which claude
# Should output: /data/.local/bin/claude

claude --version
# Should output: 2.0.37 (Claude Code)
```

Check PATH:
```bash
echo $PATH
# Should start with: /data/.local/bin:...
```

## Future Updates

When updating Claude Code:
1. The installer will automatically use the existing `/root/.local/bin` path
2. Since `/root/.local/bin` is ephemeral, you should manually ensure installations go to `/data/.local/`
3. Or reinstall by setting: `export PATH="/data/.local/bin:$PATH"` before running the installer

## Files Modified
- `/data/.zshrc` - Persistent shell configuration
- `/data/.zprofile` - Persistent login shell configuration with PATH setup
- `/homeassistant/.shellrc` - Additional persistent config (currently unused but available)
- `/root/.zshrc` - Symlinked to `/data/.zshrc`
- `/root/.zprofile` - Symlinked to `/data/.zprofile`

## Troubleshooting

If `claude` command is not found after SSH reconnect:
1. Check if symlinks still exist: `ls -la /root/.zshrc /root/.zprofile`
2. Check if persistent binary exists: `ls -la /data/.local/bin/claude`
3. Manually add to PATH: `export PATH="/data/.local/bin:$PATH"`
4. Check that config files weren't overwritten by container updates

## Backup

The following files should be backed up with your Home Assistant configuration:
- `/data/.zshrc`
- `/data/.zprofile`
- `/data/.local/share/claude/` (entire directory)
- `/homeassistant/.shellrc`
