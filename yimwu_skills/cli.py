import shutil
import sys
from importlib.resources import files
from pathlib import Path

ALL_SKILLS = ["vibe-project-standard"]


def main():
    skills = sys.argv[1:] or ALL_SKILLS
    dest = Path(".claude/skills")
    dest.mkdir(parents=True, exist_ok=True)

    for skill in skills:
        src = files("yimwu_skills.skills") / skill / "SKILL.md"
        with src.open("rb") as f:
            (dest / f"{skill}.md").write_bytes(f.read())
        print(f"Installed {skill}")
