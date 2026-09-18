#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT_PATH="$ROOT_DIR/HouseLearning.xcodeproj"
SCHEME="HouseLearning"
CONFIGURATION="Release"
OUTPUT_DIR="$ROOT_DIR/build-release"
VERSION="${VERSION:-1.0.0}"
APP_NAME="HouseLearning.app"
ARCHIVE_PATH="$OUTPUT_DIR/$APP_NAME"
ZIP_PATH="$OUTPUT_DIR/HouseLearning-macOS-universal-v${VERSION}.zip"
DMG_PATH="$OUTPUT_DIR/HouseLearning-macOS-universal-v${VERSION}.dmg"

mkdir -p "$OUTPUT_DIR"
rm -rf "$ARCHIVE_PATH" "$ZIP_PATH" "$DMG_PATH"

xcodebuild \
  -project "$PROJECT_PATH" \
  -scheme "$SCHEME" \
  -configuration "$CONFIGURATION" \
  -derivedDataPath "$ROOT_DIR/.build" \
  ARCHS="x86_64 arm64" \
  ONLY_ACTIVE_ARCH=NO \
  MACOSX_DEPLOYMENT_TARGET=10.14 \
  CODE_SIGNING_ALLOWED=NO \
  build

APP_BUILD_PATH="$ROOT_DIR/.build/Build/Products/$CONFIGURATION"
if [ ! -d "$APP_BUILD_PATH/$APP_NAME" ]; then
  echo "Build output not found at $APP_BUILD_PATH/$APP_NAME"
  exit 1
fi

cp -R "$APP_BUILD_PATH/$APP_NAME" "$ARCHIVE_PATH"
cd "$OUTPUT_DIR"
zip -r "HouseLearning-macOS-universal-v${VERSION}.zip" "$APP_NAME" >/dev/null

printf 'Created release package: %s\n' "$ZIP_PATH"
printf 'Signed DMG target: %s\n' "$DMG_PATH"
printf 'Release asset naming: HouseLearning-macOS-universal-v%s.{zip,dmg}\n' "$VERSION"
