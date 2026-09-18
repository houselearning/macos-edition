# HouseLearning for Mac

HouseLearning for Mac is the desktop app version of the HouseLearning learning platform, designed for students, families, and teachers using a focused, kid-friendly Mac-first experience.

## Features

- Math lessons and practice activities
- Science exploration and concept-based learning
- Coding and logic challenges
- SafeAI educational support for age-appropriate guidance
- Teacher dashboard and classroom tools
- Clean desktop app experience with a familiar HouseLearning visual style

## Public beta and download

- Website page: https://www.houselearning.org/home/houselearning-for-mac.html
- GitHub Releases: https://github.com/houselearning/macos-edition/releases
- Latest release asset convention: https://github.com/houselearning/macos-edition/releases/latest/download/HouseLearning-macOS-universal-v1.0.0.zip
- Signed DMG release example: HouseLearning-macOS-universal-v1.0.0.dmg

## Release asset naming convention

Use a consistent asset naming pattern for public GitHub releases:

- ZIP: HouseLearning-macOS-universal-vX.Y.Z.zip
- DMG: HouseLearning-macOS-universal-vX.Y.Z.dmg

This keeps the downloads clear, easy to track, and compatible with automatic update checks.

## GitHub Releases workflow

1. Build the app in Xcode in Release mode.
2. Archive the HouseLearning target with a universal Intel + Apple Silicon build.
3. Sign the app with an Apple Developer certificate.
4. Submit the app to Apple notarization.
5. Export a signed DMG and ZIP for the release.
6. Upload both artifacts to the latest GitHub Release.
7. Update the website page to point to the newest release asset.

## Signed DMG / ZIP instructions

- Use an Apple Developer certificate to sign the app bundle.
- Run notarization using `xcrun notarytool` or Xcode Organizer after signing.
- Publish a signed DMG for the easiest install experience for daily users.
- Keep a ZIP artifact available for direct download, quick testing, and update checks.
- Include release notes in the GitHub release description and call out the version clearly.
- The DMG should be named like: `HouseLearning-macOS-universal-v1.0.0.dmg`
- The ZIP should be named like: `HouseLearning-macOS-universal-v1.0.0.zip`

## Auto-update approach

The Mac app checks the GitHub Releases API for the latest published version and compares it to the installed app version. If a newer release is available, it prompts the user to open the latest release page or download the updated package.

## Repository

- GitHub: https://github.com/houselearning/macos-edition

## Local build

Open the Xcode project in Xcode 14+ and build the HouseLearning target.

## Notes

This project is intended to be the official public beta Mac edition of HouseLearning and keeps the same educational mission as the website: safe, engaging, and accessible learning tools for kids and students.
