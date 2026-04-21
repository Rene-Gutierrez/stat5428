
# Inference About Categorical Data

## Introduction

### From Quantitative Responses to Categorical Responses

In previous sections, inference focused on **quantitative responses**, where each observation was a numerical measurement.

In this section, the response variable is different.

Instead of measuring a numerical value for each observational unit, we record a **category**.

Examples:

- admitted / not admitted
- success / failure
- employed / unemployed
- disease present / disease absent
- preferred program A / preferred program B

For this kind of response, the main information in the data is often:

- how many fall into each category
- what proportion fall into a category

This changes both:

- the probability model
- the inferential methods.

---

### Why Counts and Proportions Require New Methods

Means are natural summaries for quantitative data.

For categorical data, means are generally not the focus.

Instead, we often study:

- counts
- proportions
- probabilities
- relationships among categorical variables.

The mathematical structure is also different.

Many methods in this chapter begin with the:

- Binomial distribution
- Multinomial distribution
- Chi-square distribution.

These replace the normal and $t$ distributions as central tools.

---

### Connection to Previous Inference Chapters

There is a strong conceptual connection with previous inference methods.

We still:

- estimate unknown parameters
- construct confidence intervals
- test hypotheses
- study sampling variability.

Only the parameter has changed.

Instead of estimating:

$$  
\mu  
$$

we may estimate:

$$  
p  
$$

a population proportion.

Inference is still based on:

estimator + standard error + sampling distribution.

This continuity is important. The ideas are familiar, even though the formulas differ.

---

## Motivating Example: Admission to a Vocational Program

Suppose a vocational education program wants to study whether gender bias exists in admissions.

---

### One Proportion Version

Question:

Is the proportion of admitted applicants who are women equal to 50%?

Parameter:

$$  
p=\text{proportion of admitted applicants who are women}  
$$

This is a one-proportion problem.

---

### Two Proportions Version

Compare admission rates:

- women applicants
- men applicants

Parameters:

$$  
p_1, p_2  
$$

Interest:

$$  
p_1-p_2  
$$

---

### Contingency Table Version

Data may be organized as:

||Admitted|Not Admitted|
|---|---|---|
|Women|||
|Men|||

This leads to contingency table methods.

---

### Stratified Version

Suppose applications come from multiple vocational specialties.

- welding
- health technology
- electronics

Then stratification may be needed.

This introduces confounding concerns.

---

## Categorical Variables and Proportions

### Categorical Variables

A categorical variable classifies units into categories.

Examples:

- nominal categories (no natural ordering)
- ordinal categories (ordered)

---

### Counts and Relative Frequencies

If $x$ observations fall in a category out of $n$ observations:

Count:

$$  
x  
$$

Relative frequency:

$$  
\frac{x}{n}  
$$

---

### The Sample Proportion

The sample proportion is:

$$  
\hat p=\frac{x}{n}  
$$

It estimates:

$$  
p  
$$

---

### Connection to the Binomial Distribution

If each observation is success/failure:

$$  
X \sim Binomial(n,p)  
$$

and

$$  
\hat p=\frac X n  
$$

This probability model drives inference.

---

## Inference About One Population Proportion

### The Parameter of Interest

Parameter:

$$  
p  
$$

---

### Point Estimation

Estimator:

$$  
\hat p  
$$

Its expected value is:

$$  
E(\hat p)=p  
$$

So it is unbiased.

---

### Standard Error of a Sample Proportion

Sampling variability:

$$  
\mathbb V(\hat p)=\frac{p(1-p)}{n}  
$$

Estimated standard error:

$$  
SE(\hat p)=\sqrt{\frac{\hat p(1-\hat p)}{n}}  
$$

---

### Confidence Interval for $p$

Large sample interval:

$$  
\hat p \pm z_{\alpha/2}  
\sqrt{\frac{\hat p(1-\hat p)}{n}}  
$$

---

### Hypothesis Testing for $p$

Test:

$$  
H_0:p=p_0  
$$

Statistic:

$$  
z=  
\frac{\hat p-p_0}  
{\sqrt{p_0(1-p_0)/n}}  
$$

---

### Conditions for the Large-Sample Approximation

Typically check:

$$  
np \text{ large}  
$$

and

$$  
n(1-p) \text{ large}  
$$

Often use expected counts at least 5 or 10.

---

### Small Sample Proportions

For small samples, normal approximations may fail.

Exact binomial methods may be preferable.

---

### Numerical Example

Suppose:

- 120 applicants
- 72 admitted

Then:

$$  
\hat p=72/120=.60  
$$

```{r
x <- 72
n <-120
phat <- x/n
phat
```

Interpretation follows the code chunk.

---

### Simulation Example

```{r
set.seed(5428)
sim <- replicate(5000, mean(rbinom(100,1,.60)))
hist(sim)
```

Simulation illustrates sampling variability.

---

## Choosing the Sample Size for Estimating a Proportion

### Margin of Error

Margin of error:

$$  
E=z_{\alpha/2}  
\sqrt{\frac{p(1-p)}{n}}  
$$

---

### Planning Sample Size

Solve for:

$$  
n  
$$

to achieve desired precision.

---

### What to Do When $p$ Is Unknown

Use conservative choice:

$$  
p=.5  
$$

because it maximizes:

$$  
p(1-p)  
$$

---

### Practical Interpretation

Larger precision requires larger sample size.

---

## Inference About the Difference Between Two Population Proportions

### The Parameter of Interest

$$  
p_1-p_2  
$$

---

### Point Estimation

$$  
\hat p_1-\hat p_2  
$$

---

### Standard Error of the Difference

$$  
\sqrt{  
\frac{\hat p_1(1-\hat p_1)}{n_1}  
+  
\frac{\hat p_2(1-\hat p_2)}{n_2}  
}  
$$

---

### Confidence Interval for $p_1-p_2$

Estimator plus/minus critical value times standard error.

---

### Hypothesis Testing for $p_1-p_2$

Test:

$$  
H_0:p_1-p_2=0  
$$

---

### Pooled Proportion Under the Null Hypothesis

Under the null:

$$  
\hat p=  
\frac{x_1+x_2}{n_1+n_2}  
$$

Used in the test standard error.

---

### Conditions for the Large-Sample Test

Check expected counts in both groups.

---

### Numerical Example

```{r
x1<-48
n1<-80
x2<-36
n2<-90
p1<-x1/n1
p2<-x2/n2
p1-p2
```

---

### Simulation Example

```{r
set.seed(5428)
d <- replicate(5000,{
mean(rbinom(80,1,.6))-
mean(rbinom(90,1,.4))
})
hist(d)
```

---

## Inference About Several Proportions

### Why Several Proportions Require a New Method

Comparing many categories requires a multivariate count framework.

---

### Observed Counts and Expected Counts

Observed:

$$  
O_i  
$$

Expected:

$$  
E_i  
$$

---

### Chi-Square Goodness-of-Fit Test

Compares:

- observed counts
    
- hypothesized counts.
    

---

### Hypotheses for a Goodness-of-Fit Test

$$  
H_0: \text{specified proportions hold}  
$$

---

### The Chi-Square Test Statistic

$$  
\chi^2=  
\sum  
\frac{(O_i-E_i)^2}{E_i}  
$$

---

### Degrees of Freedom

Typically:

$$  
k-1  
$$

---

### Conditions for the Chi-Square Approximation

Expected counts should not be too small.

---

### Numerical Example

```{r
obs<-c(32,28,40)
exp<-c(100/3,100/3,100/3)
sum((obs-exp)^2/exp)
```

---

## Contingency Tables

### Two-Way Tables

Organize joint categorical outcomes.

---

### Row Percentages and Column Percentages

Useful summaries may depend on conditioning direction.

---

### Marginal and Conditional Distributions

Marginal:

single-variable distribution.

Conditional:

distribution given another variable.

---

### Graphical Displays for Categorical Data

Possible displays:

- bar charts
    
- segmented bar charts
    
- mosaic plots
    

---

## Chi-Square Test of Independence

### Purpose of the Test

Assess whether two categorical variables are associated.

---

### Hypotheses

$$  
H_0: \text{independence}  
$$

---

### Expected Counts Under Independence

$$  
E_{ij}=  
\frac{(row\ total)(column\ total)}{grand\ total}  
$$

---

### Test Statistic

Same chi-square structure.

---

### Conditions

Expected counts sufficiently large.

---

### Interpretation

Significant does not necessarily mean strong association.

---

### Numerical Example

```{r
M <- matrix(c(35,15,25,25),2,2)
chisq.test(M)
```

---

## Chi-Square Test of Homogeneity

### Purpose of the Test

Compare distributions across populations.

---

### Difference Between Independence and Homogeneity

Mathematically similar.

Study design differs.

---

### Hypotheses

Population distributions equal.

---

### Interpretation

Focus is whether populations differ.

---

### Numerical Example

Use code structure analogous to independence test.

```{r
# placeholder for homogeneity example
```

---

## Measuring Strength of Association

### Statistical Significance versus Strength of Association

A small p-value does not measure practical importance.

---

### Difference in Proportions

Direct effect-size measure.

---

### Relative Risk

$$  
RR=\frac{p_1}{p_2}  
$$

---

### Cramer's V

Standardized association measure based on chi-square.

---

## Odds and Odds Ratios

### Odds

$$  
\text{odds}=\frac p{1-p}  
$$

---

### Odds Ratio

For $2\times2$ table:

$$  
OR=\frac{ad}{bc}  
$$

---

### Interpreting Odds Ratios

- OR =1 no association
    
- OR >1 positive association
    
- OR <1 negative association
    

---

### Confidence Interval for an Odds Ratio

Often built using log transformation.

---

### Odds Ratios and Study Design

Especially common in case-control studies.

---

## Small Counts and Exact Methods

### Why Small Counts Are a Problem

Large-sample approximations may fail.

---

### Fisher's Exact Test

Exact method for small $2\times2$ tables.

---

### Practical Guidance

Use exact methods when expected counts are very small.

---

## Combining Several $2 \times 2$ Tables

### Motivation

Multiple strata may hide confounding.

---

### Why Stratification Matters

Pooling can be misleading.

---

### Cochran-Mantel-Haenszel Idea

Combines evidence across strata.

---

### Practical Interpretation

Adjusts for stratification.

---

## Categorical Data and Study Design

### Surveys and Proportions

Sampling design matters.

---

### Experiments and Proportions

Randomization supports causal interpretation.

---

### Observational Studies and Confounding

Association is not automatically causation.

---

## What to Check Before Applying Categorical Inference

### Study Design

Check how data were collected.

---

### Type of Response

Binary?  
Multinomial?  
Contingency table?

---

### Sample Size and Expected Counts

Check assumptions.

---

### Interpretation

Statistical significance and substantive interpretation both matter.

---

## Reporting Results for Categorical Data

### What to Report

Typically report:

- estimate
    
- confidence interval
    
- test result
    
- effect size
    
- interpretation
    

---

### Avoiding Common Mistakes

Common mistakes:

- reporting only p-values
    
- ignoring effect size
    
- confusing association and causation
    

---

## Research Study

### Does Gender Bias Exist in the Selection of Students for Vocational Education?

This section can integrate:

- one proportion methods
    
- two proportion methods
    
- contingency tables
    
- stratified analysis
    

```{r
# placeholder for integrated research study analysis
```

This can serve as a unifying case study for the entire chapter.

---

## Summary

Major tools introduced:

- one proportion inference
    
- two proportion inference
    
- chi-square methods
    
- odds ratios
    
- exact methods
    
- stratified methods
    

Major idea:

Categorical inference extends the same logic used throughout previous files:

estimate

quantify uncertainty

test hypotheses

interpret in context.

---

## Key Formulas

Sample proportion:

$$  
\hat p=\frac xn  
$$

Variance:

$$  
\mathbb V(\hat p)=\frac{p(1-p)}n  
$$

One proportion z statistic:

$$  
z=  
\frac{\hat p-p_0}  
{\sqrt{p_0(1-p_0)/n}}  
$$

Difference in proportions:

$$  
\hat p_1-\hat p_2  
$$

Relative Risk:

$$  
RR=\frac{p_1}{p_2}  
$$

Odds Ratio:

$$  
OR=\frac{ad}{bc}  
$$

Chi-square:

$$  
\chi^2=  
\sum  
\frac{(O-E)^2}{E}  
$$