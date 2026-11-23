#!/usr/bin/env bash
# Build dist/lifecycle-decision-tree-map.zip with the skill folder at the zip root,
# ready for Claude → Customize → Skills → Upload a skill.
set -euo pipefail
cd "$(dirname "$0")/.."
SKILL=lifecycle-decision-tree-map
mkdir -p dist
rm -f "dist/$SKILL.zip"
zip -r "dist/$SKILL.zip" "$SKILL" -x '*.DS_Store'
echo "Created dist/$SKILL.zip"
