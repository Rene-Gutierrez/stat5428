
# Linear Regression and Correlation

## Introduction

In the previous chapters, the course developed methods for describing data, understanding probability, and making inferences about means, proportions, and variability. A natural next step is to study the relationship between two quantitative variables.

Many practical questions involve one variable that may help explain or predict another. For example:

- how does study time relate to exam performance?
- how does fertilizer level relate to crop yield?
- how does temperature relate to electricity use?
- how does dosage relate to response in a medical study?

In these settings, we are no longer focusing only on a single mean or a difference of means. Instead, we want to describe and analyze how one quantitative variable changes as another changes.

This chapter introduces two related ideas:

- linear regression, which models the average relationship between two quantitative variables
- correlation, which measures the strength and direction of a linear relationship

A key idea throughout the chapter is that regression is primarily about describing and predicting, while correlation is primarily about measuring association.

***

## Motivating Example: Study Time and Exam Performance

Suppose an instructor wants to study the relationship between the number of hours a student studies for an exam and the student’s exam score.

For each student, two variables are recorded:

- $x$: number of hours studied
- $y$: exam score

This example will be used throughout the chapter.

It is simple enough for students to understand immediately, but it also captures the main questions of regression analysis:

- Is there a relationship between study time and score?
- Is the relationship positive or negative?
- Is a straight line a reasonable description?
- How much does the average score increase as study time increases?
- Can the line be used to predict the score of a new student?
- How much uncertainty is there in those predictions?

This example also allows discussion of important cautions: a strong association does not automatically imply causation, and other factors such as prior preparation, sleep, or test anxiety may also affect performance.

***

## The Role of Regression in the Course

Earlier in the course, Chapter 3 introduced scatterplots and correlation as descriptive tools for studying the relationship between two variables. This chapter returns to those ideas, but now does something fundamentally new: it introduces an explicit **statistical model** for that relationship.

This is an important transition in the course.

In the earlier inference chapters, we often focused on parameters such as:

- a population mean
- a difference of means
- a population proportion
- a population variance

At first glance, those chapters may seem less model-based than regression. But in reality, they also relied on statistical models. The difference is that those models were much simpler and often easier to overlook.

For example, inference about a population mean is already based on a model for the data. When we estimate $\mu$ or test hypotheses about $\mu$, we are not working with raw numbers alone. We are assuming that the observed values come from some probability distribution with:

- a center
- a spread
- and, depending on the method, sometimes additional assumptions such as normality or approximate normality of the sampling distribution

So even one-sample inference is already a form of model-based inference.

The model is just simple enough that it may not look like a “model” in the same way regression does.

In inference about a mean, we are essentially assuming that:

- there is a population distribution for the observations
- that distribution has a mean $\mu$
- repeated sampling from that distribution produces a sample mean with a known or approximately known sampling distribution

That is already a modeling step. We have already made assumptions about how the data were generated.

Regression makes this modeling aspect much more visible.

Instead of modeling only the distribution of a single variable, regression models how the distribution of a response variable changes as another variable changes. In other words, the object of inference is no longer just a single population quantity such as a mean. It is now a **relationship**.

This is why regression marks an important conceptual expansion of the course.

In simple linear regression, the model says that the mean of the response variable depends on the explanatory variable through a linear form. So the inferential questions are about quantities such as:

- the slope of the line
- the intercept of the line
- the mean response for a given value of $x$
- the prediction of a new response for a given value of $x$

Thus, regression does not replace the earlier ideas of inference. Instead, it builds on them.

The earlier chapters showed that inference requires a model, even in simple settings such as estimating a mean. Regression now makes that point more explicit by introducing a model for how two variables are related, rather than only modeling one variable in isolation.

So this chapter can be viewed as the point in the course where the role of modeling becomes more visible:

- earlier inference chapters already assumed a probability model for the data
- regression extends that idea to a model for the relationship between variables
- the main goal shifts from estimating isolated parameters to understanding and inferring a functional relationship

In that sense, regression is not the beginning of model-based inference, but rather the point where model-based inference becomes more clearly recognizable.
***

## Explanatory and Response Variables

Before fitting any regression model, it is important to distinguish clearly the roles of the two variables.

This distinction is not just a matter of plotting conventions. It is built into the logic of the regression model itself.

In regression, the two variables do **not** play symmetric roles.

***

### Explanatory Variable

The **explanatory variable** is the variable used to help explain, predict, or structure the behavior of the response variable.

In the motivating example, the explanatory variable is study time, denoted by $x$.

It is the variable whose values define the different settings at which we want to understand the behavior of the response.

For example, if we ask how exam score changes as study time increases, then study time is the explanatory variable because it provides the values relative to which the response is modeled.

In many regression settings, the explanatory variable is treated as fixed, or at least as known once the data are collected.

That does not necessarily mean that the values of $x$ were chosen by the researcher. In some studies they are chosen, and in others they are simply observed. But for the purposes of the regression model, the inferential statements are usually made **conditional on the observed values of $x$**.

So even if the explanatory variable is random in a broader real-world sense, the regression model is built as though we are conditioning on the observed $x$ values.

This is a very important modeling idea.

***

### Response Variable

The **response variable** is the outcome of primary interest.

In the motivating example, the response variable is exam score, denoted by $y$.

The response variable is the variable whose behavior we are trying to explain or predict.

In regression, the response variable is the one treated as **random**.

That is, for a given value of the explanatory variable $x$, the observed value of $y$ is allowed to vary.

Different individuals with the same study time may still have different exam scores because of many other factors not explicitly included in the model, such as prior preparation, sleep, stress, or random variation.

So the model is not saying that one value of $x$ determines one exact value of $y$.  
Instead, it says that for each value of $x$, there is a distribution of possible $y$ values.

This is one of the central ideas of regression.

Regression models the behavior of the **response distribution given the explanatory variable**.

In simple linear regression, the main object being modeled is the conditional mean of the response:

$$
E(y \mid x).
$$

So the response variable is random, while the explanatory variable provides the conditioning information.

***

### Conditional View of the Model

This distinction becomes even clearer when we write the regression model in conditional form.

The model is about the distribution of $y$ **given** $x$.

So when we write a simple linear regression model, we are really saying something like:

$$
y \mid x
\text{ has a distribution with mean }
\beta_0 + \beta_1 x.
$$

This means:

- once $x$ is given,
- the response $y$ is still random,
- but its mean depends on $x$ through a linear relationship.

That is why the explanatory variable is not treated in the same way as the response variable.

The explanatory variable tells us **where** we are looking.  
The response variable tells us **what random outcome occurs at that value**.

Even when the explanatory variable itself is random in the broader data-generating process, regression is usually formulated **conditionally on the observed $x$ values**.

So the randomness that the model directly describes is the randomness in the response variable.

***

### Why the Distinction Matters

Regression is not symmetric.

Regressing $y$ on $x$ is not the same as regressing $x$ on $y$.

This is because the model is specifically built to describe the distribution of the response variable conditional on the explanatory variable, not the other way around.

The explanatory variable is placed on the horizontal axis, and the response variable is placed on the vertical axis.

That graphical convention reflects the deeper modeling structure:

- $x$ is treated as the input or conditioning variable
- $y$ is treated as the random output

This distinction also matters conceptually.

If the scientific question is how a response changes when an explanatory variable changes, then the regression model should reflect that direction.

For example:

- if we want to understand how exam score changes with study time, then exam score is the response and study time is the explanatory variable
- if we instead wanted to study how study habits vary across different score groups, that would be a different question and would lead to a different model

So the roles of the variables should be determined by the scientific question, not just by convenience.

***

### Intuition

A useful way to think about regression is this:

> The explanatory variable defines the setting, and the response variable is the random outcome observed at that setting.

If several students all study for 5 hours, we would not expect them all to earn the exact same exam score. Their scores vary. That variation is part of what the regression model is trying to describe.

The explanatory variable does not have that role in the model. Its purpose is to index or explain changes in the response.

So the regression line should not be interpreted as saying that $x$ produces a single exact value of $y$.

Instead, it describes how the **average response** changes with $x$, while allowing random variation around that average.

***

### Summary

In regression, the explanatory and response variables have fundamentally different roles.

- The **explanatory variable** provides the conditioning information and is usually treated as fixed or as observed.
- The **response variable** is random and is modeled conditionally on the explanatory variable.

Thus, regression is about the distribution of

$$
y \mid x,
$$

not about the joint distribution of the two variables in a symmetric way.

This is why the distinction between explanatory and response variables is essential before fitting or interpreting any regression model.


***

## Scatterplots and First Impressions

A regression analysis should begin with a graph.

### Scatterplot

A scatterplot displays each observational unit as a point with coordinates $(x,y)$.

In the study-time example, each point represents one student.

### What to Look For

A scatterplot helps answer the following questions:

- Is the relationship roughly increasing or decreasing?
- Does a straight line seem reasonable?
- Are there outliers?
- Is the spread of the points roughly constant?
- Are there separate groups that should not be combined?

### Why the Graph Comes First

A numerical summary alone can hide important structure. A scatterplot can reveal curvature, clusters, or unusual points that may make a simple linear regression inappropriate.

Thus, the graph should be treated as the first diagnostic tool, not as an optional decoration.

```{r sim-lin-reg-scatterplots-relationships}
# Scatter Plots Patterns

# Simulation Parameters
n  <- 100
s2 <- 20

# Simulates the Explanatory Variable
x <- runif(n = n, min = 0, max = 10)

# Linear relationship
aLin <- -10
bLin <-  5
fLin <- function(x){aLin + bLin * x}
yLin <- fLin(x) + rnorm(n = n, sd = sqrt(s2))

# Quadratic Relationship
aQua <-  1
bQua <- -20
cQua <-  2
fQua <- function(x){aQua + bQua * x + cQua * x^2}
yQua <- fQua(x) + rnorm(n = n, sd = sqrt(s2))

# Square Root Relationship
aSqr <- -30
bSqr <- 20
fSqr <- function(x){aSqr + bSqr * sqrt(x)}
ySqr <- fSqr(x) + rnorm(n = n, sd = sqrt(s2))

# Logarithm Relationship
aLog <- -5
bLog <- 10
fLog <- function(x){aLog + bLog * log(x)}
yLog <- fLog(x) + rnorm(n = n, sd = sqrt(s2))


# Plots the Relationships
par(mfrow = c(2, 2))
ymax <- max(yLin, yQua, yLog, ySqr)
ymin <- min(yLin, yQua, yLog, ySqr)
# linear Relationship
plot(x    = x,
     y    = yLin,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Linear Relationship")
curve(fLin,
      add  = TRUE,
      col  = rgb(1, 0, 0, 0.5),
      lwd  = 3)

# Quadratic Relationship
plot(x = x,
     y = yQua,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Quadratic Relationship")
curve(fQua,
      add = TRUE,
      col = rgb(1, 0, 0, 0.5),
      lwd = 3)

# Square Root Relationship
plot(x = x,
     y = ySqr,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Square Root Relationship")
curve(fSqr,
      add = TRUE,
      col = rgb(1, 0, 0, 0.5),
      lwd = 3)

# Logarithmic Relationship
plot(x = x,
     y = yLog,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Logarithmic Relationship")
curve(fLog,
      add = TRUE,
      col = rgb(1, 0, 0, 0.5),
      lwd = 3)
```

***

## The Simple Linear Regression Model

### The Population Regression Line

Simple linear regression models the mean response as a linear function of the explanatory variable:

$$
E(y \mid x) = \beta_0 + \beta_1 x
$$

where:

- $\beta_0$ is the intercept
- $\beta_1$ is the slope

### Interpretation of the Intercept

The intercept $\beta_0$ is the mean value of $y$ when $x=0$.

Its practical meaning depends on the setting. In some problems, $x=0$ is meaningful; in others, it is not.

For example, if $x$ is hours studied, then $\beta_0$ is the mean exam score for students who studied zero hours.

### Interpretation of the Slope

The slope $\beta_1$ describes how the mean response changes when $x$ increases by one unit.

In the study-time example, $\beta_1$ is the change in mean exam score associated with one additional hour of study.

If $\beta_1 > 0$, the relationship is increasing.

If $\beta_1 < 0$, the relationship is decreasing.

If $\beta_1 = 0$, there is no linear relationship in the mean response.

### Adding Random Error

Individual observations will not lie exactly on the line. A more complete model is

$$
y_i = \beta_0 + \beta_1 x_i + e_i
$$

where $e_i$ represents the deviation of the observed response from the mean response at $x_i$.

This form says that each observation is made of two parts:

- a systematic part, $\beta_0 + \beta_1 x_i$
- a random part, $e_i$

### Assumptions

For the usual simple linear regression model, we assume:

1. the mean response is linear in $x$
2. the errors have mean 0
3. the errors have common variance $\sigma^2$
4. the errors are independent
5. for inference, the errors are often assumed to be approximately normal

These assumptions should be explained intuitively rather than formally.

***

## Why a Line?

A straight line is the simplest way to describe a changing average response.

It will not be appropriate in every setting, but it is often a useful first approximation.

A linear model is especially attractive because:

- it is easy to interpret
- it summarizes the direction of the relationship
- it provides a clear measure of rate of change through the slope
- it supports estimation, testing, and prediction

Students should understand that fitting a line does not mean the true relationship is exactly linear. It means that a line is being used as a useful model for the observed pattern.

***

## Estimating the Regression Line

The population parameters $\beta_0$ and $\beta_1$ are unknown, so they must be estimated from the sample.

### The Estimated Regression Line

The sample regression line is

$$
\hat{y} = b_0 + b_1 x
$$

where:

- $b_0$ estimates $\beta_0$
- $b_1$ estimates $\beta_1$

### Least Squares Idea

The most common method for estimating the line is least squares.

For each observation, the residual is

$$
e_i = y_i - \hat{y}_i
$$

where $\hat{y}_i$ is the predicted value from the line.

Least squares chooses the line that makes the sum of squared residuals as small as possible:

$$
\sum (y_i - \hat{y}_i)^2
$$

### Why Squared Residuals?

Squaring does two things:

- it prevents positive and negative residuals from canceling
- it penalizes large deviations more heavily than small deviations

### Interpreting the Fitted Line

The fitted line summarizes the average trend in the data.

It should not be interpreted as saying every observation follows the line exactly. Rather, it gives the predicted mean response at each value of $x$.

***

## Residuals

Residuals are central to understanding regression.

### Definition

The residual for the $i$th observation is

$$
e_i = y_i - \hat{y}_i
$$

It measures how far the observed point is above or below the fitted line.

### Interpretation

- A positive residual means the observed value is above the line.
- A negative residual means the observed value is below the line.
- A residual near 0 means the fitted line predicts that observation well.

### Why Residuals Matter

Residuals help assess:

- whether the linear model is appropriate
- whether variability is roughly constant
- whether unusual observations are present

Residuals are not just leftover noise. They are one of the main tools for checking the adequacy of the model.


```{r lin-reg-residuals}
# Residual Plots Patterns

# Simulation Parameters
n  <- 100
s2 <- 20

# Simulates the Explanatory Variable
x <- runif(n = n, min = 0, max = 10)

# Linear relationship
aLin   <- -10
bLin   <-  5
fLin   <- function(x){aLin + bLin * x}
yLin   <- fLin(x) + rnorm(n = n, sd = sqrt(s2))
fitLin <- lm(yLin ~ x)
resLin <- fitLin$residuals

# Quadratic Relationship
aQua <-  1
bQua <- -20
cQua <-  2
fQua <- function(x){aQua + bQua * x + cQua * x^2}
yQua <- fQua(x) + rnorm(n = n, sd = sqrt(s2))
fitQua <- lm(yQua ~ x)
resQua <- fitQua$residuals

# Square Root Relationship
aSqr   <- -30
bSqr   <- 20
fSqr   <- function(x){aSqr + bSqr * sqrt(x)}
ySqr   <- fSqr(x) + rnorm(n = n, sd = sqrt(s2))
fitSqr <- lm(ySqr ~ x)
resSqr <- fitSqr$residuals

# Logarithm Relationship
aLog   <- -5
bLog   <- 10
fLog   <- function(x){aLog + bLog * log(x)}
yLog   <- fLog(x) + rnorm(n = n, sd = sqrt(s2))
fitLog <- lm(yLog ~ x)
resLog <- fitLog$residuals


# Plots the Relationships
par(mfrow = c(2, 2))
ymax <- max(resLin, resQua, resLog, resSqr)
ymin <- min(resLin, resQua, resLog, resSqr)
# linear Relationship
plot(x    = x,
     y    = resLin,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Linear Residuals")
abline(h = 0, col = rgb(1, 0, 0, 0.5), lwd = 3)

# Quadratic Relationship
plot(x = x,
     y = resQua,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Quadratic Residuals")
abline(h = 0, col = rgb(1, 0, 0, 0.5), lwd = 3)

# Square Root Relationship
plot(x = x,
     y = resSqr,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Square Root Residulas")
abline(h = 0, col = rgb(1, 0, 0, 0.5), lwd = 3)

# Logarithmic Relationship
plot(x = x,
     y = resLog,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "Logarithmic Residuals")
abline(h = 0, col = rgb(1, 0, 0, 0.5), lwd = 3)
```


***

## Estimating the Variability Around the Line

In addition to estimating the line itself, we need a measure of how much the data vary around that line.

### Residual Standard Deviation

A common measure is the residual standard deviation, often denoted by $s_e$.

It summarizes the typical size of the residuals.

### Interpretation

If $s_e$ is small, the points tend to lie close to the line.

If $s_e$ is large, the points are widely scattered around the line.

In the study-time example, a small residual standard deviation would mean that study time is a strong predictor of exam score. A large residual standard deviation would mean that many other factors are influencing performance.

### Why Its Size Must Be Interpreted Relative to the Overall Variability  
  
The size of the residual standard deviation should not be interpreted in isolation.  
  
A value may seem small or large depending on the overall scale and variability of the response variable.  
  
For example, suppose the residual standard deviation is 5.  
  
- If the response variable itself varies only a little, then a residual standard deviation of 5 may be quite large.  
- If the response variable varies over a very wide range, then a residual standard deviation of 5 may be fairly small.  
  
So the residual standard deviation should be interpreted **relative to the total variability in the response variable**.  
  
This is an important point.  
  
The residual standard deviation tells us how much variation is left unexplained by the regression line, but to judge whether that is a lot or a little, we should compare it to how much variation was present in the response variable to begin with.  
  
If the residual standard deviation is much smaller than the overall standard deviation of $y$, then the regression model is explaining an important part of the variation in the response.  
  
If the residual standard deviation is nearly as large as the overall standard deviation of $y$, then the regression line is not reducing the variability very much, so the linear relationship is not especially helpful for prediction.  
  
So, conceptually:  
  
- the **overall standard deviation of $y$** measures total variability in the response  
- the **residual standard deviation** measures the variability left after fitting the line  
  
This comparison helps us understand how useful the regression model really is.  

***

## Leverage

In regression, not all observations play the same role in determining the fitted line.

Some observations have explanatory-variable values that are near the center of the data, while others are far from the center. Observations that are far from the bulk of the $x$ values have greater potential to affect the fitted regression line.

This idea is called **leverage**.

***

### Basic Idea

Leverage measures how unusual an observation is with respect to its **explanatory-variable value**.

An observation has high leverage if its $x$ value is far from the mean of the explanatory variable.

An observation has low leverage if its $x$ value is close to the center of the observed $x$ values.

So leverage is about the position of a point in the **horizontal direction**, not the vertical direction.

This is important.

A point can have:

- high leverage because its $x$ value is extreme
- a large residual because its $y$ value is far from the fitted line
- both
- or neither

These are different ideas.

***

### Why Leverage Matters

Points with high leverage have greater potential to pull the regression line toward themselves.

This happens because when a point is far out in the $x$ direction, changing its fitted value can change the slope of the line more than a point near the center of the data.

Intuitively, points near the middle of the $x$ values do not have much ability to tilt the line.  
Points far to the left or far to the right can have much more influence on the slope.

So leverage helps identify observations that are in a position to strongly affect the fitted model.

However, leverage by itself is not necessarily a problem.

A point with high leverage is not automatically bad or unusual in a harmful sense. It may simply represent a legitimate observation at an extreme but important value of the explanatory variable.

The concern arises when a point has both:

- high leverage
- and a large residual

Such a point may have substantial influence on the fitted line.

***

### Leverage Is About $x$, Not About $y$

This is one of the most important conceptual points.

Leverage depends on the explanatory-variable values, not on the response values.

So if two observations have the same $x$ value, they have the same leverage, even if one has a much larger residual than the other.

Thus:

- leverage measures how far an observation is in the horizontal direction
- the residual measures how far an observation is in the vertical direction

These two ideas work together, but they are not the same.

***

### Formal Definition

In simple linear regression, the leverage of observation $i$ is often denoted by

$$
h_{ii}.
$$

Its formula is

$$
h_{ii}
=
\frac{1}{n}
+
\frac{(x_i-\bar{x})^2}{\sum_{j=1}^n (x_j-\bar{x})^2}.
$$

This formula shows directly that leverage increases as $x_i$ moves farther away from $\bar{x}$.

The first term,

$$
\frac{1}{n},
$$

is present for every observation.

The second term becomes larger when the observation is farther from the mean of the explanatory variable.

So observations near $\bar{x}$ tend to have smaller leverage, while observations far from $\bar{x}$ tend to have larger leverage.

***

### Interpretation of the Formula

The leverage formula reflects two ideas:

First, every observation contributes something to the regression fit, so every observation has some leverage.

Second, observations that are far from the center of the $x$ values contribute more strongly to determining the slope.

That is why the squared distance

$$
(x_i-\bar{x})^2
$$

appears in the formula.

The farther the $x$ value is from the mean, the larger this term becomes, and the larger the leverage becomes.

So leverage is fundamentally a measure of how much “opportunity” a point has to affect the fitted line because of where it sits in the explanatory-variable space.

***

### High and Low Leverage Points

A **low-leverage point** has an $x$ value near the center of the data.

A **high-leverage point** has an $x$ value far from the center of the data.

High-leverage points often occur near the edges of the observed range of $x$, especially if one point is much farther out than the others.

These points deserve attention because they can strongly affect the fitted slope and fitted values.

A common practical guideline is to compare leverage values to the average leverage.

In simple linear regression with an intercept, the average leverage is

$$
\frac{2}{n}.
$$

So observations with leverage substantially larger than

$$
\frac{2}{n}
$$

may be considered relatively high-leverage points.

This is not a strict rule, but it is a useful diagnostic guideline.

***

### Leverage versus Influence

Leverage and influence are related, but they are not the same.

A point with high leverage has the **potential** to influence the fitted line.

But whether it actually has strong influence depends also on whether its response value is consistent with the general pattern of the data.

For example:

- A point may have high leverage and lie close to the fitted trend. Then it may help anchor the line without causing problems.
- A point may have high leverage and also lie far from the trend. Then it may substantially distort the fit.

So leverage alone does not tell the whole story. It tells us which points are in a position to matter.

Influence is about whether they actually do matter.

***

### Graphical Intuition

A useful way to picture leverage is through a scatterplot.

```{r lin-reg-leverage}
# Residual Plots Patterns

# Simulation Parameters
n  <- 25
s2 <- 20

# Simulates the Explanatory Variable
x <- runif(n = n, min = 0, max = 10)

# Linear relationship
aLin   <- -10
bLin   <-  5
fLin   <- function(x){aLin + bLin * x}
yLin   <- fLin(x) + rnorm(n = n, sd = sqrt(s2))

# No Leverage, No Influence
x1  <- 5
y1  <- fLin(x1)
lm1 <- lm(c(yLin, y1) ~ c(x, x1))
# No Leverage, Some Influence
x2  <- 5
y2  <- fLin(x2) + 20
lm2 <- lm(c(yLin, y2) ~ c(x, x2))
# Leverage, No Influence
x3  <- 10
y3  <- fLin(x3)
lm3 <- lm(c(yLin, y3) ~ c(x, x3))
# Leverage, High Influence
x4  <- 9.5
y4  <- fLin(x4) - 40
lm4 <- lm(c(yLin, y4) ~ c(x, x4))

par(mfrow = c(2, 2))
# No Influence No Outlier
plot(x    = x,
     y    = yLin,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "No Leverage, No Outlier")
points(x = x1,
       y = y1,
       col = rgb(0, 1, 0, 1),
       pch = 15)
abline(a   = lm1$coefficients[1],
       b   = lm1$coefficients[2],
       col = rgb(0, 0, 1, 0.5),
       lwd = 3)
curve(fLin,
      add  = TRUE,
      col  = rgb(1, 0, 0, 0.5),
      lwd  = 3)
# No Influence Outlier
plot(x    = x,
     y    = yLin,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "No Leverage, Outlier")
points(x = x2,
       y = y2,
       col = rgb(0, 1, 0, 1),
       pch = 15)
abline(a   = lm2$coefficients[1],
       b   = lm2$coefficients[2],
       col = rgb(0, 0, 1, 0.5),
       lwd = 3)
curve(fLin,
      add  = TRUE,
      col  = rgb(1, 0, 0, 0.5),
      lwd  = 3)
# Influence No Outlier
plot(x    = x,
     y    = yLin,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "No Leverage, Outlier")
points(x = x3,
       y = y3,
       col = rgb(0, 1, 0, 1),
       pch = 15)
abline(a   = lm3$coefficients[1],
       b   = lm3$coefficients[2],
       col = rgb(0, 0, 1, 0.5),
       lwd = 3)
curve(fLin,
      add  = TRUE,
      col  = rgb(1, 0, 0, 0.5),
      lwd  = 3)
# Influence Outlier
plot(x    = x,
     y    = yLin,
     ylim = c(ymin, ymax),
     ylab = "",
     main = "No Leverage, Outlier")
points(x = x4,
       y = y4,
       col = rgb(0, 1, 0, 1),
       pch = 15)
abline(a   = lm4$coefficients[1],
       b   = lm4$coefficients[2],
       col = rgb(0, 0, 1, 0.5),
       lwd = 3)
curve(fLin,
      add  = TRUE,
      col  = rgb(1, 0, 0, 0.5),
      lwd  = 3)
```

***

### Why Leverage Is Useful

Leverage is useful because it helps us identify observations that deserve closer examination.

In regression analysis, we often ask:

- Are there observations with unusual $x$ values?
- Could these points strongly affect the fitted line?
- Are these points legitimate data values, or do they reflect recording problems or an unusual subgroup?

Leverage helps answer these questions.

It is especially important in applied work because a fitted regression line can sometimes depend heavily on just one or two observations with extreme explanatory-variable values.

Recognizing such points is part of good model checking.

***

### Summary

Leverage measures how unusual an observation is with respect to its explanatory-variable value.

It is a horizontal concept:

- observations far from $\bar{x}$ have higher leverage
- observations near $\bar{x}$ have lower leverage

In simple linear regression, leverage is given by

$$
h_{ii}
=
\frac{1}{n}
+
\frac{(x_i-\bar{x})^2}{\sum_{j=1}^n (x_j-\bar{x})^2}.
$$

High leverage means that a point has greater potential to affect the fitted regression line, especially the slope.

But leverage alone does not imply that a point is problematic. It becomes especially important when combined with a large residual, since then the point may have strong influence on the fit.

So leverage is one of the main diagnostic ideas used to understand how individual observations affect a regression model.
  
***

## Inference About the Regression Parameters

The textbook organizes the inferential part of the chapter around regression parameters. 

### Inference About the Slope

The slope is usually the most important parameter.

A common question is whether the explanatory variable is useful in predicting the response.

This leads to the hypotheses

$$
H_0:\beta_1 = 0
$$

versus

$$
H_a:\beta_1 \ne 0
$$

or, in one-sided form,

$$
H_a:\beta_1 > 0
\quad \text{or} \quad
H_a:\beta_1 < 0
$$

### Interpretation of the Hypotheses

If $\beta_1 = 0$, the mean response does not change linearly with $x$.

If $\beta_1 \ne 0$, there is evidence of a linear relationship between the explanatory and response variables.

### Test Statistic for the Slope

The test statistic has the familiar form

$$
t = \frac{b_1 - 0}{SE(b_1)}
$$

with appropriate degrees of freedom.

This parallels the one-sample and two-sample tests introduced earlier in the course. The new feature is that the parameter is now a slope rather than a mean or proportion.

### Confidence Interval for the Slope

A confidence interval for $\beta_1$ gives a range of plausible values for the true rate of change in the mean response.

This interval is often more informative than the hypothesis test because it provides both direction and magnitude.

### Interpreting the Slope in Context

Students should always state the slope in words.

For example:

“For each additional hour studied, the mean exam score is estimated to increase by about ___ points.”

### Inference About the Intercept

The intercept can also be tested or estimated with a confidence interval.

However, in many applications it is less scientifically important than the slope, especially when $x=0$ is outside the range of observed values.

So the chapter should include the intercept, but not give it the same emphasis as the slope.

***

## Prediction and Estimation Using Regression

The textbook separates prediction into its own section, which is a good pedagogical choice. 

### Estimating the Mean Response at a Given $x$

For a selected value of $x$, the fitted line gives

$$
\hat{y} = b_0 + b_1 x
$$

as an estimate of the mean response.

For example, we may estimate the mean exam score among students who study 4 hours.

### Predicting a New Individual Response

We may also want to predict the score of a particular new student who studies 4 hours.

This is different from estimating the mean response.

### Mean Response Versus New Observation

A confidence interval for the mean response is narrower because it targets an average.

A prediction interval for a new observation is wider because it must account for:

- uncertainty in the estimated line
- natural individual-to-individual variability around the line

This distinction is very important and should be emphasized clearly.

### Caution About Extrapolation

Regression predictions are most reliable within the range of observed $x$-values.

Using the line far outside the observed range is called extrapolation.

Extrapolation is dangerous because the true relationship may change outside the observed region.

This should be one of the major cautionary messages of the chapter.

***

## Examining Lack of Fit

The textbook includes lack of fit before correlation, which is a sensible order because students should learn to question the linear model before they rely on its summaries. 

### What Lack of Fit Means

A regression model has lack of fit when a straight line does not adequately describe the mean relationship between $x$ and $y$.

### How to Detect Lack of Fit

Lack of fit is usually examined graphically.

Important plots include:

- scatterplot of $y$ versus $x$
- residuals versus $x$
- normal probability plot of residuals

### Common Patterns

A good linear model tends to produce residuals with no clear pattern.

Signs of trouble include:

- curved patterns
- funnel-shaped spread
- clusters
- extreme outliers

### Interpreting Residual Plots

If residuals show a curved pattern, the linear model may be missing curvature.

If the spread increases with $x$, the constant-variance assumption may be questionable.

If one or two points dominate the pattern, those points should be examined carefully.

### What to Do When Linear Regression Does Not Fit Well

At this level, the chapter should focus on recognizing problems rather than developing advanced remedies.

Possible responses include:

- re-examining the data for errors
- restricting attention to a region where linearity is more reasonable
- transforming variables
- noting that a more complex model may be needed later

This naturally prepares students for later regression topics.

***

## Correlation

The book closes the main content with correlation, but in these course notes it should be presented as both a return to Chapter 3 and a contrast with regression. 

### The Correlation Coefficient

The sample correlation coefficient, denoted by $r$, measures the strength and direction of a linear relationship between two quantitative variables.

### Range of Correlation

The value of $r$ always lies between $-1$ and $1$.

- $r$ near $1$ indicates a strong positive linear relationship
- $r$ near $-1$ indicates a strong negative linear relationship
- $r$ near $0$ indicates weak or no linear relationship

### Interpretation

Correlation describes linear association, not causation.

A strong correlation does not prove that changes in one variable cause changes in the other.

### Correlation and the Scatterplot

The numerical value of $r$ should always be interpreted together with the scatterplot.

A scatterplot can reveal situations where:

- the relationship is nonlinear
- one outlier strongly affects the correlation
- separate groups are mixed together

### Correlation Versus Regression

This distinction should be explicit.

Correlation:

- is symmetric in $x$ and $y$
- measures strength and direction of linear association
- does not distinguish explanatory and response roles

Regression:

- is not symmetric
- uses an explanatory variable to model or predict a response
- focuses on a line and its parameters

### Testing for Correlation

A test can be conducted for whether the population correlation is zero.

This parallels the test for zero slope in simple linear regression.

At this level, it is useful to note that in simple linear regression, testing whether the slope is zero is equivalent to testing whether the population correlation is zero.

***

## Coefficient of Determination

A natural companion to correlation is the coefficient of determination.

### Definition

The coefficient of determination is

$$
R^2 = r^2
$$

in simple linear regression.

### Interpretation

$R^2$ is the proportion of variability in the response variable that is explained by the linear relationship with the explanatory variable.

### Why It Is Useful

It gives a descriptive summary of how well the line fits the data.

For example, if $R^2 = 0.64$, then about 64% of the variability in exam scores is explained by the linear relationship with study time.

### Caution

A large $R^2$ does not prove causation or guarantee that the model is appropriate.

A small $R^2$ does not mean the explanatory variable is useless, especially in settings where outcomes are naturally very variable.

***

## Regression, Correlation, and Causation

This section is especially important because the course earlier emphasized the difference between association and causation in study design. That same caution must appear here.

### Association Does Not Imply Causation

A regression line or a strong correlation does not, by itself, show that $x$ causes $y$.

### Why Not

Possible reasons include:

- lurking variables
- confounding
- reverse direction of influence
- observational rather than experimental study design

### Example

Students who study more may score higher, but the relationship could also reflect prior preparation, motivation, or access to resources.

### Connection to File 02

This is a good place to connect back to observational studies and experiments.

A regression relationship is easier to interpret causally when the explanatory variable arises from a well-designed experiment. In observational studies, causal claims require much greater caution.

***

## What to Check Before Using Simple Linear Regression

This section gives students a practical checklist.

### Study Design

Ask:

- Are the observational units independent?
- Is one variable being used to explain or predict the other?
- Is the study observational or experimental?

### Graphical Pattern

Ask:

- Does the scatterplot suggest a roughly linear trend?
- Are there outliers?
- Are there separate groups?

### Residual Behavior

Ask:

- Do the residuals show obvious curvature?
- Is the spread roughly constant?
- Are there unusually large residuals?

### Interpretation

Ask:

- Is the slope practically meaningful?
- Is prediction being made within the observed range?
- Is anyone making an unjustified causal claim?

***

## Reporting Results for Regression

### What to Report

A complete report should include:

- the research question
- the explanatory and response variables
- the fitted regression equation
- a scatterplot
- an interpretation of the slope
- residual-based comments on model adequacy
- confidence intervals or tests for the slope when relevant
- prediction results when relevant
- a conclusion in context

### Avoiding Common Mistakes

Common mistakes include:

- reporting only the equation without interpretation
- treating correlation as causation
- predicting far outside the observed range
- ignoring outliers or curvature
- reporting statistical significance without discussing effect size

***

## Research Study

The textbook uses a research study involving two methods for detecting *E. coli*. 

For your course notes, you may want a more accessible example, but the structure should remain similar.

A possible applied section is:

### Research Study: Can Study Time Be Used to Predict Exam Performance?

This section can bring together the chapter by including:

- a scatterplot
- a fitted line
- interpretation of slope and intercept
- a test for slope
- a confidence interval for slope
- a prediction at a selected study time
- a residual plot
- a discussion of whether the linear model is adequate
- a reminder that the relationship is associative unless supported by design

If you prefer a more scientific context, a laboratory calibration example would also work well.

***

## Summary

This chapter introduced statistical tools for studying the relationship between two quantitative variables.

The main ideas are:

- a scatterplot is the starting point for studying a relationship
- simple linear regression models the mean response as a straight-line function of an explanatory variable
- the slope describes the estimated rate of change in the mean response
- least squares chooses the fitted line by minimizing the sum of squared residuals
- inference in regression focuses mainly on the slope and on prediction
- confidence intervals for mean response and prediction intervals for new observations answer different questions
- residual plots help assess whether a linear model is appropriate
- correlation measures the strength and direction of a linear relationship
- correlation and regression describe association, but by themselves do not establish causation

***

## Key Formulas

Include the main formulas in a compact section.

Suggested formulas:

- regression model
$$
y_i = \beta_0 + \beta_1 x_i + e_i
$$

- fitted line
$$
\hat{y} = b_0 + b_1 x
$$

- residual
$$
e_i = y_i - \hat{y}_i
$$

- slope estimate
$$
b_1 = \frac{\sum (x_i-\bar{x})(y_i-\bar{y})}{\sum (x_i-\bar{x})^2}
$$

- intercept estimate
$$
b_0 = \bar{y} - b_1\bar{x}
$$

- test statistic for slope
$$
t = \frac{b_1}{SE(b_1)}
$$

- correlation coefficient
$$
r = \frac{\sum (x_i-\bar{x})(y_i-\bar{y})}
{\sqrt{\sum (x_i-\bar{x})^2 \sum (y_i-\bar{y})^2}}
$$

- coefficient of determination
$$
R^2 = r^2
$$

- test statistic for correlation
$$
t = \frac{r\sqrt{n-2}}{\sqrt{1-r^2}}
$$

At the level of these notes, the formulas should be accompanied by interpretation, not just listed.

***

## Exercises

Organize the exercises by topic.

### Scatterplots and Interpretation

Exercises asking students to:

- identify explanatory and response variables
- describe the direction and shape of a relationship
- determine whether a linear model seems reasonable

### Fitting and Interpreting a Line

Exercises computing or interpreting:

- slope
- intercept
- fitted values
- residuals

### Inference About the Slope

Exercises involving:

- confidence intervals for the slope
- tests of whether the slope is zero
- interpretation in context

### Prediction

Exercises distinguishing:

- estimating the mean response
- predicting a new individual response
- identifying extrapolation

### Residual Analysis

Exercises using residual plots to identify:

- nonlinearity
- changing spread
- unusual observations

### Correlation

Exercises interpreting:

- the sign and size of $r$
- the meaning of $R^2$
- the difference between correlation and causation

### Study Design and Causation

Exercises asking whether a regression conclusion is:

- descriptive
- predictive
- causal
- unsupported by the design