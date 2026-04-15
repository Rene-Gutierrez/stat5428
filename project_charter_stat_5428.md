# Project Charter Stat 5428

## Purpose
Create and improve lecture notes for the course Introduction to Statistical Analysis (STAT 5428). The notes are made in Rmarkdown.

## Notes Scope  
The course is a graduate-level introduction to statistical methods intended for  
students without a strong mathematical background.  
  
Guiding principles:  
- Emphasize intuition, interpretation, and data analysis.  
- Avoid calculus-based derivations.  
- Mathematical notation may be used, but explanations must remain accessible.  
- Focus on applied statistical reasoning and interpretation of results.
  
All work must only use the files contained in this project.  
External sources should not be introduced unless explicitly requested.

## Tasks

### A) Outline Creation
- Create an outline for a each class Topic
- The outline should include the subsections in markdown. And a small explanation of the section or subsection. 

### B) Outline Expansion
- Based on the last version of the outline, the notes should be created.
- All the explanations, definitions, examples should be created by the outline expansion.

### C) Notes Improvement
- Based on the latest version of the notes for a topic. The notes should be improved.
- Notes should be extended

### D) Consistency Check
The consistency checker must verify:

1. Logical consistency
   - Concepts are introduced before they are used.
   - Sections do not reference topics from future files.

2. Structural consistency
   - Correct nesting of sections and subsections.
   - Headings follow the defined hierarchy.

3. Formatting consistency
   - Definitions follow the required structure.
   - Code chunks follow the required structure.

4. Notation consistency
   - Mathematical symbols remain consistent throughout the file.

5. Course order consistency
   - Files must follow the sequence defined by the numbers
     at the beginning of the filename (01, 02, 03, ...).

### E) Quiz Elaboration
- Creates a quiz for the topics provided.

### F) Competitions Elaboration
- Create Kaggle style competitions

## Agents

### A) Outline Creator
- In charge of the creation of the outline for each topic.
- Can't access the main notes files.
- Save the file at "topic_name_outline.md".

### B) Outline Expander
- In charge of the expansion of the outline based on the "topic_name_outline.md".
- Creates definitions.
- Creates examples.
- Creates explanations.
- Save the output at "Topic-Name.md".

### C) Note Improver
- Improves the notes according to instructions.
- Specifies the way notes where improved.
- Saves the new notes at "Topic-Name.md".

### D) Consistency Checker
- Checks for mistakes in the notes, and points it out.
- Checks for consistency in the notes, and points it out.
- If prompted, it corrects the notes and saves at "Topic-Name.md".

### E) Quiz Master

The quiz must contain exactly 25 questions.

Distribution:
- 13 Multiple Choice
- 12 True/False

Multiple Choice:
- 4 options per question
- Correct answers must be evenly distributed across A, B, C, and D.

True/False:
- Equal number of True and False answers (6 each).

Additional rules:
- Questions must only reference material from the provided sections.
- Avoid notation requiring LaTeX.
- Use plain text suitable for Kahoot.
- Mix the multiple choice and true and false questions

### F) Competition Master
- The competition Master should create content for the following sections of a Kaggle competition (based on the information provided):
	- Title
	- Subtitle
	- Overview
	- Description
	- Evaluation
	- Data Set Description
- No Data generation.

## File Workflow  
  
The development process for each topic follows this sequence:  
  
1. Outline Creator  
Creates the outline file:  
topic_name_outline.Rmd  
  
2. Outline Expander  
Expands the outline into full lecture notes:  
Topic-Name.Rmd  
  
3. Note Improver  
Improves the existing notes while preserving structure:  
Topic-Name.Rmd  
  
4. Consistency Checker  
Reviews the notes for logical and formatting consistency.  
  
At each stage the agent should assume the previous stage has already been completed.  
Agents must not regenerate previous stages unless explicitly instructed.

## Editing Rules

When modifying existing notes:

- Preserve the structure of sections and subsections unless an error exists.
- Do not remove existing material unless it is incorrect.
- Prefer extending explanations rather than rewriting them.
- Do not modify existing R code chunks unless explicitly instructed.

## Section Formatting

Sections must follow this hierarchy:

# Topic Title
## Section
### Subsection
#### Example or Case Study

Rules:
- Do not skip levels in the hierarchy.
- Each section must contain at least one explanatory paragraph.
- Leave one blank line between headings and text.

## Structures

### Definitions

Definitions should follow the following structure:

```{definition, definition-tag, name="Definition Name"}
Definition text.
```

### Code Chunks

```{r code-chunk-tag}
```

### Inline Math
For in line math use single `$` signs instead of `(` and `)`. For example, this is a variable $\sigma^2$ in line math.

### Display Math
For display math use double `$$` signs instead of `\[` and `\]`. For example, this is a formula
$$ E=MC^2 $$
in display math.

## Notation

The textbook "An Introduction to Statistical Methods and Data Analysis"
will be referred to as the **reference textbook**.

Rmarkdown files will be referenced using the number prefix.

Example:
01-UsingR.Rmd -> file 01
07-Inference-About-the-Mean.Rmd -> file 07

Mathematical notation must remain consistent across all files.
If a symbol is introduced in one file it must not be redefined later.

## R Code Philosophy

R code is used to illustrate statistical concepts.

Guidelines:
- Code should be minimal and easy to understand.
- Prefer base R when possible.
- Each code chunk must be followed by a short interpretation.