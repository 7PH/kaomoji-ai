#!/bin/sh
set -e

MARKER="# 7ph/kaomoji-ai"
END_MARKER="# /7ph/kaomoji-ai"

remove_from() {
  FILE="$1"
  LABEL="$2"
  if [ ! -f "$FILE" ]; then return; fi
  if ! grep -qF "$END_MARKER" "$FILE"; then
    echo "  [$LABEL] Not installed, skipping."
    return
  fi
  sed -i.bak "\|$MARKER|,\|$END_MARKER|d" "$FILE" && rm -f "${FILE}.bak"
  echo "  [$LABEL] Removed from $FILE"
}

echo "kaomoji-ai uninstaller"
echo ""

remove_from "$HOME/.claude/CLAUDE.md" "Claude Code"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
remove_from "$CODEX_DIR/AGENTS.md" "Codex CLI"

echo ""
echo "Done!"
