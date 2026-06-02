# Quiz HTML style replication checklist

Use this reference when exact style cloning matters.

## Source of truth order

1. Live rendered behavior in the browser.
2. Actively served HTML/CSS/JS.
3. Reference HTML source.
4. Generated target HTML source.

If source and runtime conflict, trust runtime unless cache or stale artifacts are proven.

## Head cloning

For exact match requests, copy the reference `<head>` first, then adjust only target-specific fields:

- `<meta name="author">`
- `<title>`
- optional favicon or PDF link paths if they point to target-specific files

Do not hand-recreate large embedded Quarto CSS or Bootstrap icon fonts. Preserve:

- base Quarto CSS;
- Bootstrap icon font declarations;
- answer toggle CSS;
- Quarto after-body script dependencies when present.

## Body shell cloning

Preserve target quiz content but make the outer shell match:

```html
<body class="quarto-light">
<div id="quarto-content" class="page-columns page-rows-contents page-layout-article">
<div id="quarto-margin-sidebar" class="sidebar margin-sidebar">
  <nav id="TOC" role="doc-toc" class="toc-active">
```

Common required attributes:

- TOC links: `id="toc-..."`, `class="nav-link"`, `data-scroll-target="#..."`
- Section headings: `class="anchored"` and `data-anchor-id`
- Content: `<main class="content" id="quarto-document-content">`

## Answer disclosure behavior

Reference-like answer toggles usually include:

```js
const showAnswers = false;
document.addEventListener('DOMContentLoaded', function() {
  const details = document.querySelectorAll('details');
  details.forEach(detail => detail.open = false);
  ...
});
```

Expected behavior:

- initial page load hides all answer details;
- clicking a summary opens only that detail;
- clicking `显示所有答案` opens all details;
- clicking again closes all details and changes text to `显示所有答案`.

## Content preservation checks

Before and after editing, count:

- number of `<details>` blocks;
- number of `<summary>` blocks;
- number of answer labels;
- number of option lists;
- number of level-2 and level-3 sections.

Counts should only change when the user asks to add/remove questions.

## Visual QA

Use local HTTP preview for browser validation:

```bash
cd <directory-containing-html>
python3 -m http.server 8765
```

Open:

```text
http://127.0.0.1:8765/<target-file>.html
```

Verify at minimum:

- right-side table of contents is visible and sticky;
- active TOC link styling matches the reference;
- title block spacing and fonts match;
- question paragraph, option list, summary link, answer, and analysis spacing match;
- anchor icon appears beside headings on hover or as configured by the reference;
- responsive behavior hides or changes the sidebar the same way as the reference.

## Common mistakes

- Replacing target questions with reference questions.
- Keeping old custom CSS that overrides the copied reference CSS.
- Omitting Quarto after-body script, breaking anchors or active TOC state.
- Leaving TOC links without `data-scroll-target`.
- Using `file://` preview when the browser tool blocks local file URLs; serve over localhost instead.
- Matching only colors but not layout classes and scripts.
