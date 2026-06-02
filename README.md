# quiz-skills

Reusable skills for generating and formatting quiz answer pages.

This repository contains two Agent Skills compatible with Codex-style skills and Claude Code skills:

- `quiz-html-style-replicator`: replicate a reference quiz HTML page's visual style, Quarto layout, TOC, anchors, dropdown answers, and global show/hide answer behavior.
- `quiz-answer-writer`: generate consistent answers and concise explanations for single-choice, multiple-choice, and short-answer quizzes.

## Repository layout

```text
quiz-skills/
├── README.md
├── install.sh
└── skills/
    ├── quiz-html-style-replicator/
    │   ├── SKILL.md
    │   ├── agents/openai.yaml
    │   └── references/style-checklist.md
    └── quiz-answer-writer/
        ├── SKILL.md
        ├── agents/openai.yaml
        └── references/answer-patterns.md
```

Each skill is a directory containing a required `SKILL.md` plus optional references. This follows the Agent Skills pattern used by Claude Code and Codex.

## Install for Codex

Personal Codex skills live in `${CODEX_HOME:-$HOME/.codex}/skills`.

```bash
git clone git@github.com:gricials112/quiz-skills.git
cd quiz-skills
./install.sh codex
```

Manual install:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
rsync -a skills/quiz-html-style-replicator "${CODEX_HOME:-$HOME/.codex}/skills/"
rsync -a skills/quiz-answer-writer "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Restart Codex or start a new thread if the skills do not appear immediately.

Example prompts:

```text
Use $quiz-html-style-replicator to make target.html exactly match reference.html while preserving questions.
Use $quiz-answer-writer to generate dropdown answer blocks for these multiple-choice questions.
```

## Install for Claude Code

Claude Code personal skills live in `~/.claude/skills/<skill-name>/SKILL.md`. Claude Code can also load project skills from `.claude/skills/` in a repository.

Personal install:

```bash
git clone git@github.com:gricials112/quiz-skills.git
cd quiz-skills
./install.sh claude
```

Manual personal install:

```bash
mkdir -p ~/.claude/skills
rsync -a skills/quiz-html-style-replicator ~/.claude/skills/
rsync -a skills/quiz-answer-writer ~/.claude/skills/
```

Project-local install:

```bash
mkdir -p .claude/skills
rsync -a /path/to/quiz-skills/skills/quiz-html-style-replicator .claude/skills/
rsync -a /path/to/quiz-skills/skills/quiz-answer-writer .claude/skills/
```

Claude Code direct invocation examples:

```text
/quiz-html-style-replicator
/quiz-answer-writer
```

Natural-language prompts also work when they match the skill description.

## Install both

```bash
git clone git@github.com:gricials112/quiz-skills.git
cd quiz-skills
./install.sh both
```

## Update installed skills

```bash
cd quiz-skills
git pull
./install.sh both
```

Or rerun only `./install.sh codex` / `./install.sh claude`.

## Packaging for Claude.ai

For Claude.ai custom skill upload, zip the skill directory itself:

```bash
cd skills
zip -r quiz-html-style-replicator.zip quiz-html-style-replicator
zip -r quiz-answer-writer.zip quiz-answer-writer
```

The zip should contain a top-level folder with `SKILL.md` inside, not `SKILL.md` directly at the zip root.

## Notes

- Review third-party skills before installing them.
- The HTML style skill is intentionally strict: when exact matching is requested, it prefers copying the reference HTML shell/CSS/scripts and preserving only target quiz content.
- The answer writer skill is intentionally concise: answer first, then a focused explanation that teaches the decisive distinction.
