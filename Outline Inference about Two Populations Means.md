# Inference Comparing Two Population Means

## Introduction

In the previous chapter, we developed methods for making inference about a **single population mean $\mu$**.

In many real-world applications, however, the goal is not to study a single population in isolation, but rather to **compare two populations**. In this setting, the parameter of interest becomes:

$$  
\mu_1 - \mu_2.  
$$

This represents the difference in central values between two populations.

Many practical questions are inherently comparative:

- Does a treatment change an outcome?
    
- Is one group larger than another on average?
    
- Do two populations differ in their central tendency?
    

As in the previous chapter, we will develop:

- **estimation (confidence intervals)**
    
- **hypothesis testing**
    

but now applied to the difference between two means.

---

## Motivating Example: Appetite Inhibitor Drug

We will use the following example throughout the chapter.

Researchers want to study whether a **new appetite inhibitor drug reduces average caloric intake**.

---

### Independent Samples Version

Subjects are unrelated and randomly assigned to:

- treatment group (drug)
    
- control group (placebo)
    

The response variable is daily caloric intake.

This leads to inference about **two independent population means**.

---

### Matched Pairs Version

Researchers instead study **pairs of twins**:

- one twin receives the drug
    
- the other receives the placebo
    

Because twins are naturally similar, this creates **paired data**.

---

The scientific question is the same:

Does the drug change average caloric intake?

However, the **correct statistical method depends on the design**.

---

## The Role of Study Design

Before performing inference, we must identify the **data structure**.

The study design determines:

- the parameter to estimate
    
- the assumptions
    
- the standard error
    
- the valid inference procedure
    

---

### Independent Samples

- Observations are unrelated
    
- Subjects randomly assigned to groups
    

Example: unrelated individuals assigned drug or placebo

---

### Paired Data

- Observations are matched
    
- Each observation in one group corresponds to one in the other
    

Example: twins

---

These designs answer the same scientific question but require **different methods**.

---

## Assumptions

### Independent Samples

We observe:

$$  
X_1,\dots,X_{n_1}, \quad Y_1,\dots,Y_{n_2}  
$$

Assumptions:

1. Observations within each sample are independent
    
2. Samples are independent of each other
    
3. Subjects are unrelated
    
4. Random assignment
    
5. Each population has mean and variance
    
6. Populations are approximately normal or samples are large
    

Parameter:

$$  
\mu_1 - \mu_2  
$$

---

### Paired Data

Define:

$$  
D_i = X_i - Y_i  
$$

Parameter:

$$  
\mu_D  
$$

This reduces the problem to **one-sample inference on $D_i$**, connecting directly to file 07.

---

## Why Comparing Two Means Is Different from One Mean

### The Parameter of Interest

$$  
\mu_1 - \mu_2  
$$

Interpretation:

- $=0$ → no difference
    
- $>0$ → population 1 larger
    
- $<0$ → population 2 larger
    

In the drug example:

- negative values → drug reduces intake
    

---

### The Estimator

$$  
\bar{X} - \bar{Y}  
$$

This compares the sample centers.

---

### Sampling Distribution of the Difference

The variability of the difference comes from **both samples**.

For large samples:

$$  
\bar{X} - \bar{Y} \approx \text{Normal}  
$$

---

## Independent Samples

### Point Estimation

$$  
\bar{X} - \bar{Y}  
$$

Example:

```{r}
xbar <- 1800
ybar <- 2000
xbar - ybar
```

---

### Standard Error of the Difference

#### Known Variances

$$  
\sqrt{\frac{\sigma_1^2}{n_1} + \frac{\sigma_2^2}{n_2}}  
$$

---

#### Unknown Variances

##### Equal Variance Approximation

$$  
s_p^2 = \frac{(n_1-1)s_1^2 + (n_2-1)s_2^2}{n_1+n_2-2}  
$$

---

##### Unequal Variances

$$  
\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}  
$$

Example:

```{r}
s1 <- 250; s2 <- 300; n1 <- 20; n2 <- 20
sqrt(s1^2/n1 + s2^2/n2)
```

---

## Confidence Intervals for $\mu_1-\mu_2$

### Confidence Interval with Known Variances

$$  
(\bar{X}-\bar{Y}) \pm z_{\alpha/2} \cdot SE  
$$

---

### Confidence Interval with Unknown Variances

$$  
(\bar{X}-\bar{Y}) \pm t_{\alpha/2} \cdot SE  
$$

---

### Interpreting the Interval

- 0 in interval → no difference plausible
    
- 0 not in interval → evidence of difference
    
- sign indicates direction
    

Drug example:

Negative interval → supports reduction

---

## Hypothesis Testing for Independent Samples

### Formulating the Hypotheses

$$  
H_0:\mu_1-\mu_2=0  
$$

$$  
H_a:\mu_1-\mu_2<0  
$$

---

### Logical Structure of the Test

Assume $H_0$ is true.  
Reject if data are inconsistent.

---

### Test Statistic

$$  
\frac{(\bar{X}-\bar{Y})}{SE}  
$$

---

### Rejection Region and p-Value

- Compare to critical value
    
- or compute p-value
    

---

### Decision and Conclusion

Example:

```{r}
t_stat <- (-200)/87.7
t_stat
```

Conclusion: evidence drug reduces intake.

---

## Independent Samples: Interpreting the Design

### When Are Samples Independent?

- unrelated individuals
    
- separate groups
    

---

### Why Random Assignment Matters

- reduces bias
    
- ensures fair comparison
    

---

### Common Mistake: Treating Paired Data as Independent

Twin example:

Ignoring pairing increases variability → worse inference.

---

## Paired Data

### Motivation for Pairing

- control variability
    
- compare similar units
    

---

### Reducing the Problem to One Mean

$$  
D_i = X_i - Y_i  
$$

---

### Assumptions for Paired Inference

1. Differences independent
    
2. Differences approximately normal
    

---

## Confidence Intervals for Paired Data

### Point Estimate

$$  
\bar{D}  
$$

---

### Standard Error

$$  
\frac{s_D}{\sqrt{n}}  
$$

---

### Paired $t$ Confidence Interval

$$  
\bar{D} \pm t_{\alpha/2} \frac{s_D}{\sqrt{n}}  
$$

---

### Interpretation

- 0 in interval → no difference
    
- 0 not in interval → evidence
    

---

## Hypothesis Testing for Paired Data

### Hypotheses

$$  
H_0:\mu_D=0  
$$

---

### Test Statistic

$$  
\frac{\bar{D}}{s_D/\sqrt{n}}  
$$

---

### Rejection Region and p-Value

Same structure as before.

---

### Why Pairing Can Increase Precision

Removes subject variability.

Twin example: strong similarity → smaller variance.

---

## Independent Samples vs Paired Data

### How to Decide Which Method to Use

- unrelated → independent
    
- matched → paired
    

---

### Why the Choice Matters

Determines:

- parameter
    
- estimator
    
- standard error
    

---

### Compact Comparison Table

|Design|Parameter|Estimator|SE|
|---|---|---|---|
|Independent|$\mu_1-\mu_2$|$\bar{X}-\bar{Y}$|two-sample|
|Paired|$\mu_D$|$\bar{D}$|$s_D/\sqrt{n}$|

---

## Two-Sample Inference When Populations Are Not Normal

### Why Normality Matters

$t$ procedures rely on distribution assumptions.

---

### Large Sample Size

CLT → methods valid.

---

### Intermediate Sample Size

Check:

- skewness
    
- outliers
    

---

### Small Sample Size

Strong dependence on distribution shape.

---

### What to Check Before Applying Mean-Based Methods

- design
    
- sample size
    
- skewness
    
- outliers
    

---

## Nonparametric Alternatives

### Why Nonparametric Methods Are Useful

- no normality assumption
    
- robust to outliers
    

---

### Wilcoxon Rank Sum Test

Independent samples.

---

### Wilcoxon Signed-Rank Test

Paired data.

---

### Parametric vs Nonparametric Thinking

- parametric → model-based
    
- nonparametric → rank-based
    

---

### When to Prefer Nonparametric Methods

- small samples
    
- skewed data
    
- outliers
    

---

## Sample Size Determination

### Why Sample Size Matters

- affects precision
    
- affects power
    

---

### Sample Size for Estimating $\mu_1-\mu_2$

Larger $n$ → smaller error.

---

### Sample Size for Testing $\mu_1-\mu_2$

Depends on:

- $\alpha$
    
- power
    
- effect size
    

---

### Design Trade-Offs

Paired designs often need fewer observations.

---

## Graphical Tools for Comparing Two Groups

### Side-by-Side Boxplots

```{r}
boxplot(treatment, control)
```

---

### Histograms

Check shape.

---

### Plot of Paired Differences

```{r}
hist(differences)
```

---

### Why Graphs Should Come Before Formal Inference

- assess assumptions
    
- detect outliers
    

---
