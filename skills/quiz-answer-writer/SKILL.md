---
name: quiz-answer-writer
description: Generate consistent quiz answers and concise explanations for single-choice, multiple-choice, and short-answer question sets, especially for Chinese technical course review materials rendered as HTML with dropdown answer blocks.
---

# Quiz Answer Writer

Use this skill to write answer and explanation blocks for quiz questions with a consistent, review-friendly style.

The goal is not only to mark the correct option, but to make the learner remember the distinction that decides the answer.

## Answer style

- Put the answer first.
- Keep explanations concise, concrete, and course-terminology aligned.
- Explain the decisive rule, not every option mechanically.
- Mention common confusions when they are likely.
- Use the original subject language and terms; for Chinese course quizzes, write answers in Chinese.
- Do not invent missing diagrams or facts. If a diagram is absent, mark the assumption explicitly: `原题缺图，按常见...推断`.

## Formats

Single-choice:

```html
<details>
<summary>点击展开</summary>
<p><strong>答案: B</strong></p>
<p><strong>解析:</strong> ...</p>
</details>
```

Multiple-choice:

```html
<details>
<summary>点击展开</summary>
<p><strong>答案: A、B、D</strong></p>
<p><strong>解析:</strong> ...</p>
</details>
```

Short answer:

```html
<details>
<summary>点击展开</summary>
<p><strong>答案:</strong> ...</p>
<p><strong>解析:</strong> ...</p>
</details>
```

When the surrounding page is copied from a reference HTML, preserve the reference's exact `<summary>` whitespace and paragraph style.

## Generation workflow

1. Classify the question type: single-choice, multiple-choice, or short answer.
2. Solve from source material, course terminology, or stable domain knowledge.
3. Write the answer label:
   - Single option: `答案: B`
   - Multiple options: `答案: A、B、C`
   - Short answer: `答案:` followed by the response text.
4. Write the explanation:
   - Start from the positive rule.
   - Contrast the most tempting wrong interpretation.
   - Keep it one paragraph unless a list materially improves clarity.
5. Check consistency:
   - option letters match the actual option order;
   - Chinese punctuation is consistent;
   - code/API names stay in original spelling;
   - no contradiction between answer and explanation.

Read `references/answer-patterns.md` for detailed patterns and anti-patterns.

## Quality bar

An answer block is acceptable when a learner can infer:

- what the correct answer is;
- why it is correct;
- what misconception would lead to a wrong answer;
- which concise rule to remember for review.
