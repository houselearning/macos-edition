#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT_PATH="$ROOT_DIR/HouseLearning.xcodeproj"
SCHEME="HouseLearning"
CONFIGURATION="Release"
OUTPUT_DIR="$ROOT_DIR/build-release"
VERSION="${VERSION:-1.0.0}"
APP_NAME="HouseLearning.app"
APP_BUNDLE_PATH="$OUTPUT_DIR/$APP_NAME"
APP_ZIP_PATH="$OUTPUT_DIR/HouseLearning-macOS-universal-v${VERSION}.app.zip"
ZIP_PATH="$OUTPUT_DIR/HouseLearning-macOS-universal-v${VERSION}.zip"
DMG_PATH="$OUTPUT_DIR/HouseLearning-macOS-universal-v${VERSION}.dmg"
ICON_SOURCE="$ROOT_DIR/icon.png"
ICONSET_DIR="$ROOT_DIR/.build/AppIcon.iconset"

mkdir -p "$OUTPUT_DIR"
rm -rf "$APP_BUNDLE_PATH" "$APP_ZIP_PATH" "$ZIP_PATH" "$DMG_PATH" "$ICONSET_DIR"

xcodebuild \
  -project "$PROJECT_PATH" \
  -scheme "$SCHEME" \
  -configuration "$CONFIGURATION" \
  -derivedDataPath "$ROOT_DIR/.build" \
  ARCHS="x86_64 arm64" \
  ONLY_ACTIVE_ARCH=NO \
  MACOSX_DEPLOYMENT_TARGET=12.0 \
  CODE_SIGNING_ALLOWED=NO \
  build

APP_BUILD_PATH="$ROOT_DIR/.build/Build/Products/$CONFIGURATION"
if [ ! -d "$APP_BUILD_PATH/$APP_NAME" ]; then
  echo "Build output not found at $APP_BUILD_PATH/$APP_NAME"
  exit 1
fi

mkdir -p "$ICONSET_DIR"
for entry in \
  "16x16|16" \
  "16x16@2x|32" \
  "32x32|32" \
  "32x32@2x|64" \
  "128x128|128" \
  "128x128@2x|256" \
  "256x256|256" \
  "256x256@2x|512" \
  "512x512|512" \
  "512x512@2x|1024"; do
  name="${entry%%|*}"
  size="${entry##*|}"
  sips -Z "$size" "$ICON_SOURCE" --out "$ICONSET_DIR/icon_${name}.png" >/dev/null
done

iconutil -c icns "$ICONSET_DIR" -o "$OUTPUT_DIR/AppIcon.icns"

cp -R "$APP_BUILD_PATH/$APP_NAME" "$APP_BUNDLE_PATH"
mkdir -p "$APP_BUNDLE_PATH/Contents/Resources"
cp "$OUTPUT_DIR/AppIcon.icns" "$APP_BUNDLE_PATH/Contents/Resources/AppIcon.icns"

if [ -f "$APP_BUNDLE_PATH/Contents/Info.plist" ]; then
  /usr/libexec/PlistBuddy -c "Delete :CFBundleIconFile" "$APP_BUNDLE_PATH/Contents/Info.plist" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :CFBundleIconFile string AppIcon" "$APP_BUNDLE_PATH/Contents/Info.plist"
  /usr/libexec/PlistBuddy -c "Delete :CFBundleIconName" "$APP_BUNDLE_PATH/Contents/Info.plist" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :CFBundleIconName string AppIcon" "$APP_BUNDLE_PATH/Contents/Info.plist"
fi

cd "$OUTPUT_DIR"
zip -r "HouseLearning-macOS-universal-v${VERSION}.app.zip" "$APP_NAME" >/dev/null
zip -r "HouseLearning-macOS-universal-v${VERSION}.zip" "$APP_NAME" >/dev/null
hdiutil create -srcfolder "$APP_BUNDLE_PATH" -volname "HouseLearning" -ov -format UDZO "$DMG_PATH" >/dev/null

printf 'Created app bundle: %s\n' "$APP_BUNDLE_PATH"
printf 'Created app zip: %s\n' "$APP_ZIP_PATH"
printf 'Created DMG: %s\n' "$DMG_PATH"
printf 'Release asset naming: HouseLearning-macOS-universal-v%s.{app.zip,dmg}\n' "$VERSION"
