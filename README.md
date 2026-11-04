# FamilyMonitor Android Build

This repository contains a minimal Kivy app and a GitHub Actions workflow intended to build an APK.

## Run locally with Docker

```bash
docker build -t familymonitor-builder .
docker run --rm -it -v ${PWD}:/workspace familymonitor-builder /bin/bash
cd /workspace
buildozer -v android debug
```

## Notes

- The Docker build config installs the Android SDK, platform tools, build tools, and NDK required by Buildozer.
- This avoids the GitHub-hosted runner path issues that often break `python-for-android`.
- If you prefer to build directly in GitHub Actions, keep using the workflow file in `.github/workflows/build.yml`.
