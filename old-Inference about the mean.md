# Inference About the Mean

## Introduction

The simplest type of statistical inference concerns **one parameter in one population**. Before comparing multiple populations or modeling complex relationships, we begin with the most fundamental case:

> Inference about the population mean.

This is the natural starting point because:

- The mean is often the parameter of primary interest.
- Its sampling distribution is well understood.
- The Central Limit Theorem provides broad applicability.

Methods for inference fall into two broad categories:

- Estimation  
- Hypothesis testing  

In estimation, we attempt to learn the value of the population mean.  
In hypothesis testing, we evaluate a claim about the value of the population mean.

Throughout this chapter, we emphasize a computational perspective. Rather than relying only on formulas, we simulate sampling distributions to understand the logic of inference.

---

## Example: Blood Alcohol Level

Suppose we want to determine the true blood alcohol concentration (BAC) of an individual.

The testing device reports measurements with random error. The manufacturer specifies that measurement errors are normally distributed with known standard deviation:

- Measurement error standard deviation: 0.03
- Errors are unbiased (mean zero)

If the true BAC is $\mu$, each observed measurement can be modeled as:

$$
X_i = \mu + \varepsilon_i,
$$

where the errors are independent and normally distributed.

We are interested only in the **mean BAC level** $\mu$.

This example will guide our study of:

- Point estimation
- Confidence intervals
- Hypothesis testing
- Sample size determination

## Assumptions

Statistical inference about the mean relies on several assumptions about the data generating process.

Suppose we observe measurements

$$
X_1, X_2, \ldots, X_n
$$

from a population with mean $\mu$ and variance $\sigma^2$.

We assume:

1. **Independence**

The observations are independent.

$$
X_1, X_2, \ldots, X_n \text{ are independent.}
$$

2. **Constant Mean**

Each observation has the same population mean

$$
\mathbb{E}(X_i) = \mu.
$$

3. **Constant Variance**

Each observation has the same variance

$$
\mathbb{V}(X_i) = \sigma^2.
$$

4. **Normality or Large Sample Size**

Either

* the population distribution is normal, or
* the sample size is sufficiently large so that the **Central Limit Theorem** applies.

Under these assumptions, the sample mean has sampling distribution

$$
\bar{X} \sim N\left(\mu,\frac{\sigma^2}{n}\right)
$$

when the population is normal, and is approximately normal for large samples.

---

## Point Estimation

The first step in statistical inference is computing a **point estimate**.

If we assume the measurements are normally distributed with mean $\mu$, the natural estimator is the sample mean:

$$
\bar{X} = \frac{1}{n}\sum_{i=1}^n X_i.
$$

Why the sample mean?

From probability theory:

- $\mathbb{E}(\bar{X}) = \mu$
- $\mathbb{V}(\bar{X}) = \frac{\sigma^2}{n}$
- If the population is normal, $\bar{X}$ is exactly normally distributed.

We verify this through simulation.

```{r inf-mea-point-estimate-distribution}
set.seed(123)

mu  <- 0.085
sd  <- 0.03
n   <- 5
B   <- 5000

means <- replicate(B, mean(rnorm(n, mu, sd)))

mean(means)
sd(means)
hist(means, breaks = 50, probability=TRUE, main="Sampling Distribution of the Sample Mean")
abline(v=mu, col="blue", lwd=2)
```

The histogram approximates a normal distribution centered at the true mean.

---

## Interval Estimation

The sample mean is random. Reporting only $\bar{X}$ does not indicate how close it is likely to be to $\mu$.

To quantify uncertainty, we construct a **confidence interval**.

Because the population variance is known and the data are normal (or $n$ is large), the sampling distribution of the sample mean is:

$$\bar{X} \sim N\left(\mu, \frac{\sigma^2}{n}\right)$$

This is the key starting point. The mean of $\bar{X}$ is $\mu$, and its standard deviation (the standard error) is $\sigma/\sqrt{n}$.

---

### Step 1: Standardize

To derive the interval, we standardize $\bar{X}$:

$$
Z = \frac{\bar{X} - \mu}{\sigma/\sqrt{n}}.
$$

Since $\bar{X}$ is normal, this standardized variable follows:

$$
Z \sim N(0,1).
$$

---

### Step 2: Pick a Confidence Level 1 - $\alpha$

We choose a confidence level between $0$ and $1$,

$$ 1 - \alpha $$

Based on this level and for the standard normal distribution, we select an approapiate quantile 

$$ z_{\alpha/2} $$

that satisfies:

$$
P(-z_{\alpha/2} \le Z \le z_{\alpha/2}) = 1 - \alpha
$$

This statement says that the probability a standard normal variable falls between $-z_{\alpha/2}$ and $z_{\alpha/2}$ is $1-\alpha$.

---

### Step 3: Substitute Back for $Z$

Replace $Z$ with its definition:

$$
P\left( z_{\alpha/2} \le
  \frac{\bar{X} - \mu}{\sigma/\sqrt{n}}
  \le
  z_{\alpha/2}
  \right)
  =
  1 - \alpha.
$$

---

### Step 4: Solve for $\mu$

Multiply all parts by $\sigma/\sqrt{n}$:

$$
P\left(
 z_{\alpha/2}\frac{\sigma}{\sqrt{n}}
  \le
  \bar{X} - \mu
  \le
  z_{\alpha/2}\frac{\sigma}{\sqrt{n}}
  \right)
  =
  1 - \alpha.
$$

Now rearrange to isolate $\mu$:

$$
P\left(
\bar{X} - z_{\alpha/2}\frac{\sigma}{\sqrt{n}}
\le
\mu
\le
\bar{X} + z_{\alpha/2}\frac{\sigma}{\sqrt{n}}
\right) = 
1 - \alpha.
$$

---

### Final Result

This leads directly to the $(1-\alpha)$ confidence interval:

$$
\bar{X} \pm z_{\alpha/2} \frac{\sigma}{\sqrt{n}}
$$

---

### Interpretation

The randomness is in $\bar{X}$, not in $\mu$.

Before observing the data, the interval is random. In repeated sampling, intervals constructed this way will contain the true mean $\mu$ approximately $100(1-\alpha)%$ of the time.

After the data are observed, the interval is fixed, and we interpret it using this long-run frequency property.

---

This derivation shows that confidence intervals are not ad hoc formulas. They arise directly from:

1. The sampling distribution of $\bar{X}$
2. Standardization
3. A probability statement about the standard normal distribution

Everything follows from these three ingredients.


### Example Interval Estimation

We return to the blood alcohol example and simulate repeated confidence intervals.

```{r inf-mea-interval-estimation-example}
set.seed(123)

n      <- 5
alpha  <- 0.05
reaAlc <- 0.085
sd     <- 0.03
rep    <- 100

ci_bounds <- replicate(rep, {
  obsErr <- rnorm(n, 0, sd)
  x <- reaAlc + obsErr
  x_bar <- mean(x)

  lower <- x_bar - qnorm(1 - alpha/2) * sd / sqrt(n)
  upper <- x_bar + qnorm(1 - alpha/2) * sd / sqrt(n)

  c(lower, upper)
})

ci_bounds <- t(ci_bounds)

plot(ci_bounds[,1], type="n",
     ylim=range(ci_bounds),
     xlab="Simulation Index",
     ylab="Confidence Interval")

for(i in 1:nrow(ci_bounds)){
  segments(i, ci_bounds[i,1], i, ci_bounds[i,2],
           col = ifelse(ci_bounds[i,1] <= reaAlc &
                        ci_bounds[i,2] >= reaAlc,
                        "black", "red"))
}

abline(h = reaAlc, col="blue", lwd=2)
```

Black intervals contain the true mean.
Red intervals miss it.

This visualizes the long-run interpretation:

> A 95% confidence procedure captures the true mean approximately 95% of the time.

---

Understood. Below is the revised section with all display equations written using `$$ ... $$` for proper R Markdown rendering.

---

### Choosing the Sample Size for Estimating the Population Mean

When constructing a confidence interval, we often face a practical design question:

> How large must the sample be to achieve a desired level of precision?

Precision is measured by the **margin of error**, which is half the width of the confidence interval.

For a $(1-\alpha)$ confidence interval with known variance,

$$
E = z_{\alpha/2}\frac{\sigma}{\sqrt{n}}.
$$

This formula shows that the margin of error depends on:

1. The confidence level (through $z_{\alpha/2}$),
2. The population standard deviation $\sigma$,
3. The sample size $n$.

---

#### Solving for the Required Sample Size

Suppose we want the margin of error to be no larger than some specified value $E$.
We solve the equation algebraically for $n$.

Starting from

$$
E = z_{\alpha/2}\frac{\sigma}{\sqrt{n}},
$$

multiply both sides by $\sqrt{n}$:

$$
E\sqrt{n} = z_{\alpha/2}\sigma.
$$

Now divide both sides by $E$:

$$
\sqrt{n} = \frac{z_{\alpha/2}\sigma}{E}.
$$

Finally, square both sides:

$$
n = \left(\frac{z_{\alpha/2}\sigma}{E}\right)^2.
$$

This formula gives the **minimum required sample size** to guarantee the desired precision.

---

#### Interpretation of the Formula

The structure of the formula immediately reveals:

* If $\sigma$ increases, $n$ must increase.
* If we want smaller $E$ (greater precision), $n$ must increase.
* If we increase the confidence level (larger $z_{\alpha/2}$), $n$ must increase.

Notice that $n$ depends on the square of these quantities.

---

#### Interpreting “Width 0.02”

If the officer wants the confidence interval to have total width 0.02, then the margin of error must be:

$$
E = 0.01.
$$

The resulting confidence interval would have the form:

$$
\bar{X} \pm 0.01.
$$

Using:

* $\sigma = 0.03$
* $\alpha = 0.05$
* $E = 0.01$

we compute:

```{r inf-mea-sample-size}
sigma <- 0.03
alpha <- 0.05
E     <- 0.01

z <- qnorm(1 - alpha/2)

n_required <- (z * sigma / E)^2
ceiling(n_required)
```

We always **round up** to ensure the margin of error does not exceed the target value.

---

#### The Square-Root Relationship

From the margin of error formula,

$$
E = z_{\alpha/2}\frac{\sigma}{\sqrt{n}},
$$

we see that

$$
E \propto \frac{1}{\sqrt{n}}.
$$

This square-root relationship has an important implication:

* To cut the margin of error in half, we must quadruple the sample size.

Thus, gains in precision become increasingly expensive as we demand tighter intervals.

---

#### If the Sample Size Is Fixed

In many applications, $n$ is constrained by budget or logistics.
If $n$ is fixed, we compute the resulting margin of error:

```{r inf-mea-sample-size-fixed}
n <- 5
E <- z * sigma / sqrt(n)
E
```

This tells us how precise our estimate can realistically be.

---

#### Design Trade-Off

Choosing $n$ is fundamentally a planning decision that balances:

* Statistical precision,
* Confidence level,
* Practical cost.

Larger $n$ leads to:

* Smaller margin of error,
* More reliable estimation,
* Greater financial and operational cost.

Understanding this trade-off is essential in statistical study design and will reappear later in hypothesis testing and power analysis.

---

## Hypothesis Testing

In estimation, we attempt to learn $\mu$.

In hypothesis testing, we evaluate a **specific claim** about $\mu$.

Suppose the legal limit for blood alcohol concentration (BAC) is 0.08. We wish to determine whether the true mean BAC exceeds this limit.

We formalize the problem as:

* $H_0: \mu = 0.08$
* $H_a: \mu > 0.08$

The null hypothesis represents the legal benchmark. The alternative reflects the claim that the limit has been exceeded.

---

### Logical Structure of a Test

Hypothesis testing follows a proof-by-contradiction structure:

1. Assume $H_0$ is true.
2. Determine what values of the data would be unlikely under that assumption.
3. If the observed data fall in that unlikely region, reject $H_0$.

The key is understanding the sampling distribution under $H_0$.

If $H_0$ is true, then

$$
\bar{X} \sim N\left(\mu_0,\frac{\sigma^2}{n}\right).
$$

Standardizing gives the test statistic:

$$
z = \frac{\bar{X} - \mu_0}{\sigma/\sqrt{n}}.
$$

Under $H_0$,

$$
Z \sim N(0,1).
$$

This distribution determines the rejection region.

---

### Developing the Rejection Region

For a right-tailed test at significance level $\alpha$, we want:

$$
P(\text{Reject } H_0 \mid H_0 \text{ true}) = \alpha.
$$

Since $Z \sim N(0,1)$ under $H_0$, we choose a cutoff $z_\alpha$ such that

$$
P(Z \ge z_\alpha) = \alpha.
$$

This defines the **critical value**.

Therefore, the rejection region in terms of $Z$ is:

$$
\text{Reject } H_0 \quad \text{if} \quad Z \ge z_\alpha.
$$

Substituting back for $Z$:

$$
\frac{\bar{X} - \mu_0}{\sigma/\sqrt{n}} \ge z_\alpha.
$$

Solving for $\bar{X}$ gives the rejection region in the original measurement scale:

$$
\bar{X} \ge \mu_0 + z_\alpha \frac{\sigma}{\sqrt{n}}.
$$

This is an important step: the rejection region can be expressed either in standardized units (z-scores) or directly in terms of the sample mean.

---

### Interpretation of the Rejection Region

The rejection region consists of sample means that are sufficiently large that they would be rare if $\mu = 0.08$ were true.

Thus:

* If $\bar{X}$ falls in this region, we conclude the data are inconsistent with $H_0$.
* If $\bar{X}$ does not fall in this region, we do not have enough evidence to reject $H_0$.

Note carefully:

Failing to reject $H_0$ does **not** mean $H_0$ is true.
It means the data are not sufficiently inconsistent with it.

---

### Components of a Test

A complete hypothesis test requires:

1. **Null hypothesis ($H_0$)**
   The benchmark claim being evaluated.

2. **Alternative hypothesis ($H_a$)**
   The competing claim.

3. **Significance level ($\alpha$)**
   The probability of a Type I error.

4. **Test statistic**
   A standardized measure of discrepancy between data and $H_0$.

5. **Sampling distribution under $H_0$**
   Determines probabilities and critical values.

6. **Rejection region**
   Values of the test statistic that lead to rejection.

7. **Decision rule and conclusion**
   A formal statement in context.

---

### Type I and Type II Errors

Two types of errors are possible.

#### Type I Error

Rejecting $H_0$ when it is true.

$$
P(\text{Type I Error}) = \alpha.
$$

In this context: concluding BAC exceeds 0.08 when in fact it does not.

---

#### Type II Error

Failing to reject $H_0$ when it is false.

$$
P(\text{Type II Error}) = \beta.
$$

In this context: failing to detect that BAC exceeds 0.08 when it truly does.

---

#### Trade-Off

For fixed $n$:

* Decreasing $\alpha$ (being more conservative)
  → increases $\beta$
  → reduces power.

This trade-off is fundamental in test design.

---

### One-Tailed Blood Alcohol Test (Numerical Illustration)

We simulate data where the true mean is slightly above the legal limit.

```{r inf-mea-hypothesis-bac}
set.seed(123)

mu0 <- 0.08
mu  <- 0.09
sd  <- 0.03
n   <- 5

x <- rnorm(n, mu, sd)
xbar <- mean(x)
# Test Statistic
z <- (xbar - mu0) / (sd / sqrt(n))
z
# Rejection Region
R <- qnorm(p = 1 - alpha)
# Result of the Test
if(z > R){
  print("Reject the Null Hypothesis")
} else {
  print("Fail to reject the Null Hypothesis")
}
```

If $z \ge z_\alpha$, we reject $H_0$.

Otherwise, we fail to reject $H_0$.

---

### General Forms of Rejection Regions

#### Case 1: Right-Tailed Test

$$
H_a: \mu > \mu_0
$$

Reject if

$$
Z \ge z_\alpha.
$$

---

#### Case 2: Left-Tailed Test

$$
H_a: \mu < \mu_0
$$

Reject if

$$
Z \le -z_\alpha.
$$

---

#### Case 3: Two-Tailed Test

$$
H_a: \mu \ne \mu_0
$$

We split $\alpha$ across both tails:

$$
P(|Z| \ge z_{\alpha/2}) = \alpha.
$$

Reject if

$$
|Z| \ge z_{\alpha/2}.
$$

---

### Significance Level and p-Value

Instead of precomputing a rejection region, we may compute a **p-value**.

The p-value is:

> The probability, assuming $H_0$ is true, of observing a test statistic at least as extreme as the one obtained.

For a right-tailed test:

$$
\text{p-value} = P(Z \ge z_{\text{obs}} \mid H_0 \text{ true}).
$$

```r
p_value <- 1 - pnorm(z)
p_value
```

---

#### Decision Rule Using the p-Value

* If p-value $\le \alpha$, reject $H_0$.
* If p-value $> \alpha$, fail to reject $H_0$.

Both approaches—critical value and p-value—are mathematically equivalent.
They differ only in presentation.

---

### Conceptual Summary

Hypothesis testing proceeds by:

1. Modeling the sampling distribution under $H_0$.
2. Determining what outcomes are rare under that model.
3. Comparing observed data to that rarity threshold.

The rejection region formalizes what “rare” means.
The p-value quantifies how rare the observed result actually is.

Both methods operationalize the same probabilistic logic.


### Choosing the Sample Size for Testing the Population Mean

To detect a meaningful deviation from $\mu_0$, we must choose $n$ carefully.

Larger samples:

* Reduce standard error
* Increase power (reduce $\beta$)

A detailed study of power and Type II error will follow in later sections.

---

## Inference About the Mean Unknown Variance

In the previous sections, we constructed confidence intervals and hypothesis tests assuming that the population variance $ \sigma^2 $ was known. In practice, this assumption is rarely realistic. Most of the time the population variance is **unknown** and must be estimated from the sample.

When the population variance is unknown, we replace $ \sigma $ with the **sample standard deviation** $ s $. However, this replacement introduces additional uncertainty. Because of this, the sampling distribution of the standardized mean is no longer normal. Instead, it follows the **Student (t) distribution**.

The Student $ t $ distribution allows us to correctly account for the additional variability introduced by estimating $ \sigma $.

---

### Review Properties of the Student t Distribution

The Student $t$ distribution is a continuous probability distribution that arises frequently in statistical inference. It forms a family of distributions indexed by a parameter called the **degrees of freedom**, denoted by $\nu$.

#### Definition

A random variable $T$ is said to follow a **Student $t$ distribution with $\nu$ degrees of freedom**, written

$$
T \sim t_\nu ,
$$

if it can be expressed as the ratio

$$
T = \frac{Z}{\sqrt{U/\nu}},
$$

where

* $Z \sim N(0,1)$,
* $U \sim \chi^2_\nu$,
* $Z$ and $U$ are independent.

This representation shows that the $t$ distribution is closely related to both the normal and chi–square distributions.

#### Shape and Behavior

The Student $t$ distribution has several key characteristics:

* It is **symmetric around 0**.
* It has **heavier tails** than the standard normal distribution.
* Its exact shape depends on the **degrees of freedom $\nu$**.

For small values of $\nu$, the distribution has very heavy tails, meaning that extreme values occur with higher probability. As $\nu$ increases, the distribution becomes more concentrated around zero.

```{r t-distribution-plot}
curve(dt(x, df = 5), from = -4, to = 4,
      ylab = "Density",
      xlab = "t value")

curve(dnorm(x), from = -4, to = 4, add = TRUE, lty = 2)
legend("topright",
       legend = c("t (df=5)", "Normal"),
       lty = c(1,2))
```

#### Relationship with the Normal Distribution

As the degrees of freedom increase, the Student $t$ distribution approaches the standard normal distribution. In particular,

$$
t_\nu \rightarrow N(0,1) \quad \text{as } \nu \to \infty .
$$

Thus, for large values of $\nu$, the $t$ distribution and the standard normal distribution are nearly indistinguishable.

#### Mean and Variance

The mean and variance of the $t$ distribution depend on $\nu$:

* If $\nu > 1$, the mean is

$$
\mathbb{E}(T) = 0 .
$$

* If $\nu > 2$, the variance is

$$
\mathbb{V}(T) = \frac{\nu}{\nu - 2}.
$$

For $\nu \le 2$, the variance is infinite, reflecting the heavy tails of the distribution.

#### Critical Values

For many statistical procedures, we use **quantiles** (critical values) of the $t$ distribution.

For a probability level $\alpha$, the value $t_{\alpha,\nu}$ satisfies

$$
P(T > t_{\alpha,\nu}) = \alpha, \quad T \sim t_\nu .
$$

Because the distribution is symmetric,

$$
P(T < -t_{\alpha,\nu}) = \alpha.
$$

These critical values are commonly tabulated and are used to construct confidence intervals and perform hypothesis tests.

---

### Confidence Intervals Unknown Variance

When the population variance is unknown, the confidence interval for the population mean is constructed using the Student (t) distribution.

```{definition, ci-mean-unknown-var, name="Confidence Interval for the Mean (Unknown Variance)"}
Let \( y_1, y_2, \dots, y_n \) be a random sample from a normal population with unknown variance.

A \( (1-\alpha) \) confidence interval for the population mean \( \mu \) is

$$
\bar{y} \pm t_{\alpha/2,\,n-1}\frac{s}{\sqrt{n}}
$$

where

* \( \bar{y} \) is the sample mean
* \( s \) is the sample standard deviation
* \( t_{\alpha/2,n-1} \) is the critical value from the Student \(t\) distribution with \( n-1 \) degrees of freedom
```

Compared to the normal confidence interval, the only difference is that we use the **(t) critical value** instead of the **(z) critical value**.

Because the (t) distribution has heavier tails, the resulting confidence interval is typically **wider**, reflecting the additional uncertainty.

---

#### Example BAC continued unknown variance

Suppose we collected a small sample of $n=10$ BAC measurements from a driver suspected of driving under the influence. The legal limit is $0.08$. Since the population variance is unknown and the sample size is small, we use the **Student $t$ distribution**.

We compute a **95% confidence interval** for the population mean BAC.

First, suppose the observed BAC values are:

```{r inf-mea-bac-unkown-variance-confidence}
# Set Seed
set.seed(2026)

# Simulation settings
n      <- 5
alpha  <- 0.05
reaBac <- 0.085
sd     <- 0.03

# Draws Samples
bac <- rnorm(n = n, mean = reaBac, sd = sd)
```

We begin by computing the sample size, sample mean, and sample standard deviation.

```{r bac-summary}
n <- length(bac)
y_bar <- mean(bac)
s <- sd(bac)

n
y_bar
s
```

Next, we compute the **standard error of the mean**.

```{r bac-se}
se <- s / sqrt(n)
se
```

For a 95% confidence interval we need the critical value from the $t$ distribution with $n-1$ degrees of freedom.

```{r bac-tvalue}
alpha <- 0.05
t_crit <- qt(1 - alpha/2, df = n - 1)
t_crit
```

The confidence interval is

$$
\bar{y} \pm t_{\alpha/2,,n-1}\frac{s}{\sqrt{n}}
$$

We compute the interval endpoints.

```{r bac-ci}
lower <- y_bar - t_crit * se
upper <- y_bar + t_crit * se

lower
upper
```

Thus, the **95% confidence interval for the mean BAC** is (`r round(lower, 4)`, `r round(upper, 4)`).

This interval provides a range of plausible values for the population mean BAC.

Finally, we can verify the result using the built-in R function `t.test()`.

```{r bac-t-test}
t.test(bac, conf.level = 0.95)
```

The output confirms the same confidence interval calculated manually.

---

### Hypothesis Testing Unknown Variance

Hypothesis testing for the mean with unknown variance also uses the Student (t) distribution.

```{definition, t-test-mean, name="t Test for the Mean"}
Let \( y_1, y_2, \dots, y_n \) be a random sample from a normal population with unknown variance.

To test

* \( H_0: \mu = \mu_0 \)

we use the test statistic

$$
t = \frac{\bar{y}-\mu_0}{s/\sqrt{n}}
$$

Under \( H_0 \), this statistic follows a Student \(t\) distribution with \( n-1 \) degrees of freedom.
```

The steps for the hypothesis test are:

1. State the hypotheses
2. Compute the test statistic
3. Determine the rejection region or compute the p-value
4. Make a decision
5. Interpret the result in context

---

#### Example BAC continued Hypothesis testing unknown variance

We now test whether the **mean BAC of drivers exceeds the legal limit of 0.08**. Since the population variance is unknown and the sample size is small, we use a **one-sample $t$ test**.

We test

* $H_0: \mu = 0.08$
* $H_a: \mu > 0.08$

Suppose the BAC measurements are:

```{r inf-mea-bac-unkown-variance-hypothesis}
# Set Seed
set.seed(2026)

# Simulation settings
n      <- 5
alpha  <- 0.05
reaBac <- 0.085
sd     <- 0.03

# Draws Samples
bac <- rnorm(n = n, mean = reaBac, sd = sd)
```

First, compute the sample size, sample mean, and sample standard deviation.

```{r bac-summary-test}
n <- length(bac)
y_bar <- mean(bac)
s <- sd(bac)

n
y_bar
s
```

Next, compute the **test statistic**

$$
T = \frac{\bar{y}-\mu_0}{s/\sqrt{n}}
$$

where $\mu_0 = 0.08$.

```{r bac-test-statistic}
mu0 <- 0.08

t_stat <- (y_bar - mu0) / (s / sqrt(n))
t_stat
```

The test statistic follows a $t$ distribution with $n-1$ degrees of freedom under the null hypothesis.

\nu = n-1

```{r bac-df}
df <- n - 1
df
```

Next, compute the **p-value** for the right-tailed test.

```{r bac-pvalue}
p_value <- 1 - pt(t_stat, df)
p_value
```

If the p-value is smaller than the significance level $\alpha = 0.05$, we reject $H_0$.

```{r bac-decision}
alpha <- 0.05
p_value < alpha
```

Thus, if this value is `TRUE`, we reject the null hypothesis and conclude that the **mean BAC is greater than the legal limit**.

Finally, we can verify the result using the built-in `t.test()` function in R.

```{r bac-t-test-verify}
t.test(bac, mu = 0.08, alternative = "greater")
```

This function performs the same hypothesis test and returns the test statistic, degrees of freedom, p-value, and confidence interval.

---

## Not Normally Distributed Population

In the previous sections, our inference procedures relied on an important assumption:

The population from which the sample is drawn is **normally distributed**.

When this assumption holds, the theoretical distributions used in inference are exact. In particular:

* The sample mean has an exact normal distribution.
* When the variance is unknown, the statistic

$$
t = \frac{\bar{y}-\mu}{s/\sqrt{n}}
$$

follows a Student $t$ distribution.

However, in practice many populations are **not normally distributed**. Real-world data may be skewed, heavy-tailed, or contain outliers.

When the population distribution is not normal, the reliability of the inference procedures we developed depends strongly on the **sample size** and on whether the **population variance is known or unknown**.

We analyze three scenarios:

* Large sample size
* Intermediate sample size
* Small sample size

---

### Big Sample Size

When the sample size is **large**, the procedures previously described for inference about the mean are generally reliable even when the population distribution is not normal.

A common rule of thumb is

$$
n \ge 30
$$

although the required sample size may depend on how strongly the population deviates from normality.

The key reason these methods remain valid is the **Central Limit Theorem**, which describes the behavior of the sample mean for large samples.

---

#### Distribution of the Sample Mean

Even when the population is not normally distributed, the **Central Limit Theorem** states that the sampling distribution of the sample mean approaches a normal distribution as the sample size becomes large.

```{definition, central-limit-theorem, name="Central Limit Theorem"}
Let $y_1, y_2, \dots, y_n$ be a random sample from a population with mean $\mu$ and variance $\sigma^2$.

As the sample size $n$ becomes large, the sampling distribution of the sample mean $\bar{y}$ approaches a normal distribution with

$$
\mathbb{E}[\bar{y}] = \mu
$$

and

$$
\mathbb{V}[\bar{y}] = \frac{\sigma^2}{n}.
$$
```

\mathbb{V}(\bar{y}) = \frac{\sigma^2}{n}

Because of this result, the sampling distribution of the sample mean is approximately normal for large $n$, even if the population distribution itself is not normal.

**Variance known**

If the population variance $\sigma^2$ is known, the standardized statistic

$$
\frac{\bar{y}-\mu}{\sigma/\sqrt{n}}
$$

is approximately standard normal for large $n$. Therefore, the **normal-based confidence intervals and hypothesis tests** introduced earlier are typically reliable.

**Variance unknown**

If the population variance is unknown, we replace $\sigma$ with the sample standard deviation $s$. For large samples, $s$ provides a good estimate of $\sigma$, and the statistic

$$
\frac{\bar{y}-\mu}{s/\sqrt{n}}
$$

is approximately normal as well.

As a result, the **Student $t$ procedures for the mean also work well for large samples**, even when the population distribution is not normal.

---

#### Distribution of the Sample Variance

The behavior of the sample variance depends more strongly on the population distribution.

If the population is normal, the sample variance has a distribution related to the chi-square distribution. If the population is not normal, this exact result no longer holds.

However, for large samples:

* The sample variance remains a **consistent estimator** of $\sigma^2$.
* The standard error $s/\sqrt{n}$ provides a good approximation to the variability of the sample mean.

Therefore:

* When the variance is **known**, inference about the mean remains reliable.
* When the variance is **unknown**, the $t$-based procedures also remain reliable for large $n$.

---

#### Example Big Sample Size

```{r inf-mea-big-sample}
# set.seed(123)

# Simulation settings
rep    <- 1000

n      <- 30
alpha  <- 0.05
reaAlc <- 0.085
sd     <- 0.03
df     <- 1
varKno <- FALSE

densityChiSquare <- function(x) {dchisq(x = x, df = df)}

curve(densityChiSquare, from = 0, to = 5 * df)

ci_bounds <- replicate(rep, {
  # Creates the Observations
  obsErr <- (rchisq(n, df = df) - df) / sqrt(2 * df) * sd
  x      <- reaAlc + obsErr
  # Computes the Sample Mean
  x_bar  <- mean(x)
  # Computes the Sample Standard Error if Necesary
  if(varKno){
    s <- sd
  } else {
    s <- sd(x)
  }
  # Computes the Confidence Intervals
  lower <- x_bar - qt(1 - alpha/2, df = n-1) * s / sqrt(n)
  upper <- x_bar + qt(1 - alpha/2, df = n-1) * s / sqrt(n)
  # Saves
  c(lower, upper)
})

ci_bounds <- t(ci_bounds)

conInt <-  ci_bounds[, 1] <= reaAlc & ci_bounds[, 2] >= reaAlc

print(paste0("Percentage of Confidence Intervals that contain the True Parameter: ", mean(conInt)))
```

### Intermediate Sample Size

When the sample size is **moderate**, the reliability of inference procedures depends more strongly on the shape of the population distribution.

A rough range for intermediate sample sizes is

$$
10 \le n < 30.
$$

In this range, the Central Limit Theorem begins to take effect, but the sampling distributions may still be influenced by the shape of the population.

---

#### Distribution of the Sample Mean

For intermediate sample sizes, the sampling distribution of $\bar{y}$ may still show noticeable deviations from normality if the population distribution is highly skewed or heavy-tailed.

**Variance known**

If the variance is known, the statistic

$$
\frac{\bar{y}-\mu}{\sigma/\sqrt{n}}
$$

is no longer guaranteed to follow a normal distribution unless the population itself is normal.

However:

* If the population distribution is **approximately symmetric**, the normal approximation is often acceptable.
* If the population is **strongly skewed**, the approximation may be poor.

**Variance unknown**

When the variance is unknown, an additional source of variability appears because $s$ is estimated from the sample.

In this situation:

* The statistic used in the $t$ procedures may not follow the theoretical $t$ distribution.
* The inference procedures may still work reasonably well when the population is close to symmetric.
* If the population is highly skewed, the procedures may become unreliable.

---

#### Distribution of the Sample Variance

For intermediate sample sizes, the sample variance can be sensitive to extreme observations.

This is particularly important when:

* the population distribution has heavy tails, or
* the sample contains outliers.

Consequently:

* When the variance is **known**, inference about the mean depends mainly on the behavior of the sample mean.
* When the variance is **unknown**, the additional uncertainty from estimating $s$ can further reduce the reliability of the inference procedures.

---

### Small Sample Size

When the sample size is **small**, deviations from normality can have a large effect on inference.

A common rule of thumb is

$$
n < 10.
$$

In this situation, the theoretical results that justify the inference procedures developed earlier rely strongly on the assumption that the population distribution is normal.

---

#### Distribution of the Sample Mean

If the population is not normally distributed and the sample size is small, the sampling distribution of the sample mean may be:

* skewed,
* heavy-tailed,
* very different from a normal distribution.

**Variance known**

Even if the population variance $\sigma^2$ is known, the statistic

$$
\frac{\bar{y}-\mu}{\sigma/\sqrt{n}}
$$

does not necessarily follow a normal distribution when the population is not normal.

Therefore, the **normal-based inference procedures may not be valid**.

**Variance unknown**

When the variance is unknown, the situation becomes even more difficult.

The $t$ procedures rely on the assumption that the population distribution is normal when the sample size is small. If this assumption does not hold, the statistic

$$
\frac{\bar{y}-\mu}{s/\sqrt{n}}
$$

may not follow the Student $t$ distribution.

As a result, the confidence intervals and hypothesis tests based on the $t$ distribution may perform poorly.

---

#### Distribution of the Sample Variance

The sample variance is particularly unstable when the sample size is small.

In small samples:

* a single extreme observation can greatly affect $s^2$,
* the estimate of the standard error $s/\sqrt{n}$ may be unreliable.

These issues further reduce the reliability of the inference procedures when the variance is **unknown**.

---

When both conditions occur:

* the **sample size is small**, and
* the **population distribution is not approximately normal**,

standard inference procedures for the mean may not be reliable.

In such situations, alternative approaches can be used that rely less heavily on distributional assumptions. One important approach is **resampling methods**, which we introduce in the next section.

---

### What to Check Before Applying Inference Methods

When the population distribution is not known to be normal, the reliability of inference about the mean depends mainly on three elements:

* the **sample size**
* the **shape of the data distribution**
* whether the **population variance is known or unknown**

Before applying the inference procedures introduced earlier, it is useful to evaluate the situation using the following guidelines.

---

#### Large Sample Size ($n \ge 30$)

When the sample size is large, inference procedures for the mean are generally reliable even if the population is not normally distributed.

This occurs because the **Central Limit Theorem** ensures that the sampling distribution of the sample mean is approximately normal.

What to check:

* Verify that the **sample size is large** ($n \ge 30$).
* Look at a **histogram or boxplot** to confirm that there are no extreme outliers.
* Confirm that the sample was obtained using an appropriate **random sampling method**.

If these conditions are satisfied:

* If the variance $\sigma^2$ is **known**, the **normal-based procedures** for inference about $\mu$ can be used.
* If the variance $\sigma^2$ is **unknown**, the **Student $t$ procedures** introduced earlier can be used.

---

#### Intermediate Sample Size ($10 \le n < 30$)

When the sample size is moderate, the validity of the inference procedures depends more strongly on the shape of the data.

What to check:

* Examine the **shape of the sample distribution** using graphical summaries such as histograms or boxplots.
* Determine whether the data appear **approximately symmetric**.
* Check for **strong skewness or extreme outliers**.

If the data appear approximately symmetric:

* The previously described inference procedures are often still reasonable.

If the data show strong skewness or outliers:

* The normal or $t$ approximations may be unreliable.

The effect of non-normality is particularly important when the **variance is unknown**, since the standard error must be estimated using the sample variance.

---

#### Small Sample Size ($n < 10$)

When the sample size is small, inference procedures depend heavily on the assumption that the population distribution is normal.

What to check:

* Consider whether there is **strong prior knowledge** that the population distribution is approximately normal.
* Examine the sample data for **skewness or outliers**, keeping in mind that small samples provide limited information about the true distribution.

If the population is approximately normal:

* The inference procedures previously described remain valid.

If the population distribution is not approximately normal:

* The theoretical distributions used in those procedures may not provide reliable results.

In these situations, alternative methods that rely less on distributional assumptions can be used. One such approach is **bootstrap methods**, which will be discussed in the next section.

---

### Summary Table of When Inference Procedures Are Reliable

The following table summarizes when the inference procedures for the population mean can generally be applied when the population distribution is not known to be normal.

| Sample Size     | Population Shape                | Variance Known                         | Variance Unknown                  | Reliability of Inference                          |
| --------------- | ------------------------------- | -------------------------------------- | --------------------------------- | ------------------------------------------------- |
| $n \ge 30$      | Any reasonable distribution     | Normal procedures generally reliable   | $t$ procedures generally reliable | Usually reliable due to the Central Limit Theorem |
| $10 \le n < 30$ | Approximately symmetric         | Normal approximation often acceptable  | $t$ procedures often acceptable   | Depends on skewness and outliers                  |
| $10 \le n < 30$ | Strongly skewed or heavy-tailed | Normal approximation may be unreliable | $t$ procedures may be unreliable  | Use caution                                       |
| $n < 10$        | Approximately normal            | Normal procedures valid                | $t$ procedures valid              | Reliable if normality assumption holds            |
| $n < 10$        | Not approximately normal        | Normal procedures unreliable           | $t$ procedures unreliable         | Alternative methods recommended                   |

This table provides a practical guideline for deciding whether the inference procedures previously introduced can be applied.

When the conditions for these procedures are not satisfied, alternative approaches that rely less on distributional assumptions may be needed. One such approach is **bootstrap methods**, which are introduced in the next section.

---

## Inferences with Small n (Bootstrap Methods)

When the sample size is small, the assumptions required for the (t) methods may not hold. In particular, the methods rely on the population being approximately **normally distributed**.

If the normality assumption is questionable, we can use **bootstrap methods**.

Bootstrap methods use **resampling** to approximate the sampling distribution of a statistic.

Instead of relying on theoretical distributions, we repeatedly sample from the observed data and compute the statistic of interest.

---

### When to Apply

Bootstrap methods are useful when:

* The sample size is **small**
* The population distribution is **unknown**
* The normality assumption may not hold

They are particularly useful when theoretical sampling distributions are difficult to derive.

However, bootstrap methods still require that the sample be **representative of the population**.

---

### Steps for Bootstrap Methods about the Mean Confidence Intervals

The bootstrap approach approximates the sampling distribution of the sample mean by repeatedly sampling from the observed data.

Steps:

1. Start with the observed sample $ y_1, y_2, \dots, y_n $

2. Draw a **bootstrap sample** of size $n$ from the data **with replacement**

3. Compute the sample mean for the bootstrap sample

4. Repeat steps 2–3 many times (for example, 10,000 times)

5. The collection of bootstrap means approximates the **sampling distribution**

6. Construct a confidence interval using the **percentiles** of the bootstrap distribution

For a 95% confidence interval we use the **2.5% and 97.5% percentiles**.

```{r bootstrap-ci}
# set.seed(123)

# Simulation settings
rep    <- 10000

n      <- 10
alpha  <- 0.05
reaAlc <- 0.085
df     <- 100
B      <- 1000


densityChiSquare <- function(x) {dchisq(x = x, df = df)}

curve(densityChiSquare, from = 0, to = 5 * df)

ci_bounds <- replicate(rep, {
  # Creates the Observations
  obsErr <- (rchisq(n, df = df) - df) / sqrt(2 * df) * sd
  x      <- reaAlc + obsErr
  # Computes the Sample Mean
  x_bar  <- mean(x)
  # Resamples
  booSam <- replicate(n = B, expr = sample(x = x, size = n, replace = TRUE))
  # Computes Means
  booMea <- colMeans(booSam)
  # Computes the Quantiles
  lower <- quantile(x = booMea, probs = 0.025)
  upper <- quantile(x = booMea, probs = 0.975)
  # Saves
  c(lower, upper)
})

ci_bounds <- t(ci_bounds)

conInt <-  ci_bounds[, 1] <= reaAlc & ci_bounds[, 2] >= reaAlc

print(paste0("Number of Samples: ", n))
print(paste0("Percentage of Confidence Intervals that contain the True Parameter: ", mean(conInt)))
```

---

### Steps for Bootstrap Methods about the Mean Hypothesis Testing

Bootstrap methods can also be used for hypothesis testing.

The key idea is to simulate the sampling distribution **under the null hypothesis**.

Steps:

1. Assume the null hypothesis is true

2. Center the data so that the sample mean equals the null value

3. Draw bootstrap samples from the centered data

4. Compute the bootstrap test statistic for each sample

5. Compare the observed statistic to the bootstrap distribution

6. Compute the p-value as the proportion of simulated statistics that are more extreme than the observed statistic

```{r bootstrap-test}
# set.seed(123)

# Simulation settings
rep    <- 100

n      <- 10
alpha  <- 0.05
reaAlc <- 0.085
sd     <- 0.01
mu0    <- reaAlc
df     <- 100
B      <- 1000


densityChiSquare <- function(x) {dchisq(x = x, df = df)}

curve(densityChiSquare, from = 0, to = 5 * df)

booPva <- replicate(rep, {
  # Creates the Observations
  obsErr <- (rchisq(n, df = df) - df) / sqrt(2 * df) * sd
  x      <- reaAlc + obsErr
  # Computes the Sample Mean
  x_bar  <- mean(x)
  # Centers
  x      <- x - x_bar + mu0
  # Resamples
  booSam <- replicate(n = B, expr = sample(x = x, size = n, replace = TRUE))
  # Computes Means
  booMea <- colMeans(booSam)
  # Computes the p-value
  mean(x_bar > booMea)
})

# Percentage of Times that the null hypothesys is rejected
rejPer <- mean(booPva < alpha)
print(paste0("Error rate: ", rejPer))
```

Bootstrap hypothesis tests are especially useful when the theoretical distribution of the test statistic is unknown or unreliable.

---

### Bootstrap-$t$ or Studentized Bootstrap

When the population distribution is not normal and the sample size is not sufficiently large for the Central Limit Theorem to provide a reliable approximation, the classical normal and $t$ inference procedures may perform poorly.

A refinement of the basic bootstrap confidence interval is the **Bootstrap-$t$ (Studentized Bootstrap)** method. This approach attempts to mimic the sampling distribution of the **$t$-statistic** rather than the sampling distribution of the sample mean itself.

The classical $t$ statistic used in inference about the mean is

$$
t = \frac{\bar{y} - \mu}{s/\sqrt{n}}
$$

which standardizes the sample mean by its estimated standard error.

$$
t = \frac{\bar{y}-\mu}{s/\sqrt{n}}
$$

The Bootstrap-$t$ method applies this same idea within the bootstrap framework.

Instead of directly approximating the distribution of $\bar{y}$, we approximate the distribution of the statistic

$$
t^* = \frac{\bar{y}^* - \bar{y}}{s^*/\sqrt{n}}
$$

where

* $\bar{y}^*$ is the mean of a bootstrap sample
* $s^*$ is the standard deviation of the bootstrap sample

This procedure **studentizes** the bootstrap estimate by accounting for variability in the standard error.

The following code exemplifies the studentized bootstrap confidence intervals and hypothesis testing.

```{r mea-studentized-bootstrap-confidence-intervals}
# set.seed(123)

# Simulation settings
rep    <- 100

n      <- 5
alpha  <- 0.05
reaAlc <- 0.085
sd     <- 0.01
df     <- 1
B      <- 1000


densityChiSquare <- function(x) {dchisq(x = x, df = df)}

curve(densityChiSquare, from = 0, to = 5 * df)

ci_bounds <- replicate(rep, {
  # Creates the Observations
  obsErr <- (rchisq(n, df = df) - df) / sqrt(2 * df) * sd
  x      <- reaAlc + obsErr
  # Computes the Sample Mean
  x_bar  <- mean(x)
  # Computes the Sample SD
  sdx    <- sd(x)
  # Resamples
  booSam <- replicate(n = B, expr = sample(x = x, size = n, replace = TRUE))
  # Computes Means
  booMea <- colMeans(booSam)
  # Computes the SD
  booSD  <- apply(X = booSam, MARGIN = 2, FUN = sd)
  # Computes the t statistic
  booTst <- (booMea - x_bar) / (booSD / sqrt(n)) 
  # Computes the Quantiles of the bootstrap t
  booT025 <- quantile(x = booTst, probs = 0.025)
  booT975 <- quantile(x = booTst, probs = 0.975)
  # Computes the bootstrap upper and lower bound
  lower <- x_bar + booT025 * sdx / sqrt(n)
  upper <- x_bar + booT975 * sdx / sqrt(n)
  # Saves
  c(lower, upper)
})

ci_bounds <- t(ci_bounds)

conInt <-  ci_bounds[, 1] <= reaAlc & ci_bounds[, 2] >= reaAlc

print(paste0("Number of Samples: ", n))
print(paste0("Percentage of Confidence Intervals that contain the True Parameter: ", mean(conInt)))
```


#### Why Studentization Helps

Studentization adjusts the statistic by its estimated variability. This typically produces an approximation that is:

* more stable across different samples
* less sensitive to skewness in the population distribution
* more accurate for moderate sample sizes

Because of this adjustment, the Bootstrap-$t$ method often performs better than simpler bootstrap intervals when:

* the population distribution is skewed
* the variance is unknown
* the sample size is not very large

#### Relationship to Classical Inference

Notice that the Bootstrap-$t$ method mirrors the logic of the classical $t$ procedures discussed earlier:

| Classical Method                 | Bootstrap Analogue                         |
| -------------------------------- | ------------------------------------------ |
| $t = (\bar{y}-\mu)/(s/\sqrt{n})$ | $t^* = (\bar{y}^*-\bar{y})/(s^*/\sqrt{n})$ |
| theoretical $t$ distribution     | empirical bootstrap distribution           |
| assumptions about normality      | fewer distributional assumptions           |

Thus, the Bootstrap-$t$ method replaces the **theoretical $t$ distribution** with an **empirical distribution obtained through resampling**.

#### When the Bootstrap-$t$ Method is Useful

The Bootstrap-$t$ method becomes particularly useful in the following situations:

* the population distribution is **not normal**
* the sample size is **small or moderate**
* the variance of the population is **unknown**
* classical normal or $t$ approximations are questionable

In these settings, bootstrap approaches can provide more reliable inference by using the **observed data to approximate the sampling distribution**.

The specific implementation steps for bootstrap confidence intervals and hypothesis testing will be introduced in the next section.

