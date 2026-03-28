#!/usr/bin/env bash
set -e

REPO="https://raw.githubusercontent.com/yimwu/yimwu-skills/main"
SKILLS_DIR=".claude/skills"
ALL_SKILLS=(vibe-project-standard)

skills=("$@")
if [ ${#skills[@]} -eq 0 ]; then
  skills=("${ALL_SKILLS[@]}")
fi

mkdir -p "$SKILLS_DIR"

for skill in "${skills[@]}"; do
  echo "Installing $skill..."
  curl -fsSL "$REPO/skills/$skill/SKILL.md" -o "$SKILLS_DIR/$skill.md"
done

echo "Done. Installed: ${skills[*]}"
