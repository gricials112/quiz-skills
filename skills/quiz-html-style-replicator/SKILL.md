---
name: quiz-html-style-replicator
description: Replicate a reference quiz HTML page's visual style, Quarto layout, table of contents, anchors, details/summary answer toggles, and global show/hide answer behavior. Use when modifying generated quiz answer HTML to look and behave exactly like a provided reference file.
---

# Quiz HTML Style Replicator

Use this skill to transform a target quiz HTML file so it visually and interactively matches a reference quiz HTML file while preserving the target questions, answers, and explanations.

For exact visual cloning, prefer transplanting proven reference assets and structure over rewriting CSS from memory.

## Workflow

1. Identify the target HTML and the reference HTML.
2. Inspect both files passively before editing:
   - `<head>` metadata, embedded CSS, linked assets, scripts.
   - `#quarto-content`, sidebar, `#TOC`, `main.content`, title block.
   - `<details>`, `<summary>`, answer paragraphs, and global answer toggle behavior.
3. Preserve the target content:
   - Keep quiz sections, question text, option lists, answers, explanations, and footer unless the user asks to rewrite them.
   - Do not overwrite target questions with reference questions.
4. Clone the reference shell:
   - Reuse reference CSS and scripts when the user asks for "完全一模一样" / exact match.
   - Use the reference layout classes, sidebar/TOC structure, anchor script, and after-body Quarto script when applicable.
   - Keep only target-specific metadata such as title and author if needed.
5. Normalize answer disclosure markup:
   - Use `<details>` per question.
   - Use `<summary>点击展开</summary>` or the exact whitespace/newline formatting from the reference.
   - Put answer and analysis in separate paragraphs.
6. Add or preserve global answer toggle if present in the reference:
   - `const showAnswers = false;`
   - Initial state closes all details unless configured otherwise.
   - A fixed top-right link toggles all details and switches text between `显示所有答案` and `隐藏所有答案`.
7. Validate before reporting completion.

## Exact-match checklist

When the reference is a Quarto HTML export, match these items:

- `<div id="quarto-content" class="page-columns page-rows-contents page-layout-article">`
- `<nav id="TOC" role="doc-toc" class="toc-active">`
- TOC links include `class="nav-link"` and `data-scroll-target`.
- Nested TOC lists use the same `collapse` class pattern as the reference.
- The right-side `quarto-alternate-formats` block is present if it exists in the reference.
- `main` uses `class="content"` and `id="quarto-document-content"`.
- Headings keep `.anchored` and `data-anchor-id`.
- The reference after-body script is present if anchors, active TOC state, or Quarto behavior depend on it.

Read `references/style-checklist.md` for the detailed implementation and validation checklist.

## Validation commands

Use static checks before visual checks:

```bash
python3 - <<'PY'
from pathlib import Path
s = Path("target.html").read_text(encoding="utf-8")
print("details", s.count("<details"))
print("summaries", s.count("<summary>"))
print("answers", s.count("<strong>答案"))
print("has toggle", "answer-toggle-container" in s)
print("has quarto layout", "page-columns page-rows-contents page-layout-article" in s)
PY
```

If browser preview is needed, serve the directory over localhost instead of relying on `file://`:

```bash
python3 -m http.server 8765
```

Then open `http://127.0.0.1:8765/<file>.html` in the available browser tool and verify:

- right sidebar TOC renders like the reference;
- first question spacing matches;
- one `点击展开` reveals answer and analysis;
- `显示所有答案` opens all details and changes to `隐藏所有答案`.
