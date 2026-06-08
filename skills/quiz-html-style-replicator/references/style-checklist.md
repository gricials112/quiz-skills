# Style replication checklist

When replicating the reference HTML style, use `getComputedStyle()` + `getBoundingClientRect()` for exact values.

## Layout (grid)

```
128px | 799px(main) | 26px | 215px(sidebar) | 32px = 1200px total
```

HTML order: `<main>` first → sidebar second. Sidebar uses `grid-column: 4`.

## Typography (Noto Serif CJK SC, 17px base)

| Element | px | weight | notes |
|---------|----|--------|-------|
| body | 17px | 400 | line-height: 1.8 |
| h1 | 34px | 600 | |
| h2 | 28.05px | 600 | border-bottom, padding-bottom 8.5px |
| h3 | 24.65px | 600 | margin: 25.5px 0 8.5px |
| .subtitle.lead | 21.25px | 300 | **only** subtitle uses this |
| p (body) | 17px | 400 | intro text is normal <p> |
| li | 14.875px | 400 | |
| ol padding | — | — | 0 0 0 34px |

## TOC

| Part | color | padding |
|------|-------|---------|
| #TOC | 0.875em base | — |
| top-level a | #0d6efd (blue) | 3.4px 0 3.4px 10.2px |
| nested a (ul ul) | #212529 (dark) | 3.4px 0 3.4px 17.85px |

Set `#TOC li { font-size: 1em }` to prevent compounding.

## Details / Summary

- summary: `#0066cc`, padding 4px 8px, no border, transparent
- summary:hover: `#004499`
- details: margin 8px 0, no border, transparent
- Answer toggle: fixed top-right, `#0066cc`, `13px`

## Scroll tracking

Use IntersectionObserver: `rootMargin: '-80px 0px -60% 0px'`
