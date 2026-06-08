---
name: quiz-html-style-replicator
description: 一比一复制中文Quarto测验HTML的视觉风格（Grid布局、TOC、字体/字号/颜色、details/summary、答案切换、滚动追踪）。
---

# Quiz HTML Style Replicator

将目标HTML的视觉风格一比一复制为参考HTML的样式，保留目标题目内容和答案。提供可直接使用的 `template.html`。

## 工作流

1. **使用template.html**：直接复制 `template.html` 作为起点，填入题目内容和答案即可。
2. 如需从现有参考文件提取样式 → 用浏览器取数：`getComputedStyle()` + `getBoundingClientRect()`，填入精确像素值。
3. **注意HTML顺序**：`<main>` 在前，`<div id="quarto-margin-sidebar">` 在后。
4. **Standard answer blocks**：`<details><summary>\n点击展开\n</summary><p><strong>答案:</strong>...</p><p><strong>解析:</strong>...</p></details>`

## 精确布局（中文Quarto网格）

```
grid-template-columns: 128px minmax(auto,799px) 26px 215px 32px
                      ↑主要间距   ↑主区域     ↑间隔 ↑侧栏 ↑右侧
```
- main.content → `grid-column: 2`，max-width 799px
- #quarto-margin-sidebar → `grid-column: 4`，width 215px
- total = 128+799+26+215+32 = **1200px**

## 精确像素值参考

| 元素 | font-size | font-weight | color | 备注 |
|------|-----------|-------------|-------|------|
| body | 17px | 400 | #212529 | Noto Serif CJK SC, line-height: 1.8 |
| h1 | 34px | 600 | #212529 | line-height: 1.2 |
| h2 | 28.05px | 600 | #212529 | line-height: 1.2; margin: 0 0 17px; padding: 0 0 8.5px; border-bottom: 1px solid #dee2e6 |
| h3 | 24.65px | 600 | #212529 | line-height: 1.2; margin: 25.5px 0 8.5px |
| .subtitle.lead | 21.25px | 300 | #212529 | 标题下方大号介绍 |
| 普通段落p | 17px | 400 | #212529 | 默认body文本大小 |
| li | 14.875px | 400 | #212529 | line-height: 1.8 |
| ol | — | — | — | padding: 0 0 0 34px; margin: 0 0 17px |
| summary | 17px | 400 | **#0066cc** | padding: 4px 8px; 无边框; hover: #004499 |
| details | — | — | — | margin: 8px 0; 无边框; 透明背景 |

## TOC侧栏

- `#TOC { font-size: 0.875em }` = 14.875px
- toc-title h2: `1em/500`，margin `5.1px 0 3.4px`
- 顶级链接: **#0d6efd** (blue), padding `3.4px 0 3.4px 10.2px`
- 嵌套链接: **#212529** (dark), padding `3.4px 0 3.4px 17.85px`
- 设置 `#TOC li { font-size: 1em }` 防止叠乘

## 答案切换

- summary颜色: `#0066cc` (hover → `#004499`)
- 切换按钮: 固定右上角 `#0066cc` 链接，"显示所有答案" ↔ "隐藏所有答案"
- 初始状态: `showAnswers = false`，所有details闭合

## 滚动追踪

使用 IntersectionObserver 在滚动时高亮TOC中的当前章节（`rootMargin: '-80px 0px -60% 0px'`）。
