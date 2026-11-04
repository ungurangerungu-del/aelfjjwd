#!/usr/bin/env bash
set -euo pipefail

if ! command -v firebase >/dev/null 2>&1; then
  echo "Firebase CLI not found. Install it first: npm install -g firebase-tools"
  exit 1
fi

if [ ! -f public/apk/app-release.apk ]; then
  echo "APK not found: public/apk/app-release.apk"
  echo "Build the APK first, then copy it here."
  exit 1
fi

firebase deploy
