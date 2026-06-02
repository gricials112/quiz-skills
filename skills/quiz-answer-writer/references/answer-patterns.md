# Quiz answer writing patterns

Use this reference when generating many answers or normalizing inconsistent answer blocks.

## Single-choice pattern

Structure:

1. `答案: X`
2. One paragraph explaining the rule.
3. Optional short contrast against wrong options.

Example:

```html
<p><strong>答案: B</strong></p>
<p><strong>解析:</strong> WebDriver 是统一 API，测试脚本通过它控制不同浏览器。它不是浏览器替代品，也不直接控制渲染引擎。</p>
```

## Multiple-choice pattern

Use Chinese enumeration punctuation:

```html
<p><strong>答案: A、B、D</strong></p>
```

Explanation should name the shared criterion that includes the correct options and excludes the wrong option.

Avoid:

- `答案: ABD` when the surrounding file uses separated letters;
- mixing commas and Chinese dunhao;
- saying "以上都对" unless the option literally exists and is correct.

## Short-answer pattern

The answer can be longer, but the first sentence should still be the direct answer.

Preferred:

```html
<p><strong>答案:</strong> UML 是用于软件系统可视化、规约、构造和文档化的标准建模语言。</p>
<p><strong>解析:</strong> UML 是建模语言，不是开发过程；它描述模型表示方式，过程由 UP/RUP 等定义。</p>
```

## Explanation tone

Use compact teaching language:

- "核心理解：..."
- "区别：..."
- "口诀：..."
- "不要把...混淆为..."
- "按传统教材口径..."

These phrases help produce review notes rather than verbose textbook prose.

## Handling missing diagrams

If a question references a missing figure:

```html
<p><strong>解析:</strong> 原题缺图。按常见 BCE 图标顺序推断为 Boundary → Control → Entity。</p>
```

Do not pretend to have seen the diagram.

## Validation checklist

For every answer block:

- answer label exists;
- explanation label exists unless the user explicitly requests answer-only;
- option letter exists in the question;
- multiple-choice answer letters are sorted by option order;
- explanation does not contradict the selected option;
- code and API names preserve case;
- HTML tags are balanced.
