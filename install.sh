#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./install.sh codex
  ./install.sh claude
  ./install.sh both

Installs skills into:
  Codex:  ${CODEX_HOME:-$HOME/.codex}/skills
  Claude: $HOME/.claude/skills
USAGE
}

copy_skills() {
  local dest="$1"
  mkdir -p "$dest"
  rsync -a skills/quiz-html-style-replicator "$dest/"
  rsync -a skills/quiz-answer-writer "$dest/"
  echo "Installed skills to $dest"
}

target="${1:-}"
case "$target" in
  codex)
    copy_skills "${CODEX_HOME:-$HOME/.codex}/skills"
    ;;
  claude)
    copy_skills "$HOME/.claude/skills"
    ;;
  both)
    copy_skills "${CODEX_HOME:-$HOME/.codex}/skills"
    copy_skills "$HOME/.claude/skills"
    ;;
  *)
    usage
    exit 2
    ;;
esac
