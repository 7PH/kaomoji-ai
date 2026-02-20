#!/bin/sh
set -e

MARKER="# 7ph/kaomoji-ai"
END_MARKER="# /7ph/kaomoji-ai"

BODY=$(cat << 'EOF'
Prefer kaomoji over emojis. Use them naturally, not in every response. Craft original kaomoji that fit the mood — don't just recycle a fixed set. Examples for style reference only: ＼(^o^)／ (｡◕‿◕｡) (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧ (；一_一) (╯°□°）╯︵ ┻━┻ (ಥ_ಥ)
EOF
)

SNIPPET="
$MARKER
$BODY
$END_MARKER"

install_to() {
  FILE="$1"
  LABEL="$2"
  mkdir -p "$(dirname "$FILE")"
  touch "$FILE"
  if grep -qF "$END_MARKER" "$FILE"; then
    echo "  [$LABEL] Already installed, skipping."
  else
    printf '%s' "$SNIPPET" >> "$FILE"
    echo "  [$LABEL] Installed to $FILE"
  fi
}

echo "kaomoji-ai installer"
echo ""

INSTALLED=0

# Claude Code
if [ -d "$HOME/.claude" ]; then
  install_to "$HOME/.claude/CLAUDE.md" "Claude Code"
  INSTALLED=1
fi

# Codex CLI
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
if [ -d "$CODEX_DIR" ]; then
  install_to "$CODEX_DIR/AGENTS.md" "Codex CLI"
  INSTALLED=1
fi

echo ""
if [ "$INSTALLED" = "1" ]; then
  echo "Done! Restart your editor to apply."
else
  echo "No supported AI assistants detected. Install Claude Code or Codex CLI first."
fi
