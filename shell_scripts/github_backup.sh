#!/bin/bash
cd /homeassistant || exit 1
git config user.name "Home Assistant" 2>/dev/null || true
git config user.email "homeassistant@local" 2>/dev/null || true
if [[ -z $(git status --porcelain) ]]; then
    echo "No changes to commit"
    exit 0
fi
git add .HA_VERSION .gitignore README.md automations.yaml configuration.yaml scenes.yaml scripts.yaml 2>/dev/null
if [[ -z $(git diff --cached) ]]; then
    echo "No staged changes to commit"
    exit 0
fi
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
git commit -m "Automated backup: ${TIMESTAMP}" 2>&1
git push origin main 2>&1
echo "Backup completed successfully at ${TIMESTAMP}"
