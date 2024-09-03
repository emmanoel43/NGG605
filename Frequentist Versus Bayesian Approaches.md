# NGG6050
Emma Noel

09/03/2024

Frequentist Versus Bayesian Approaches


Exercise #1: If someone gets a positive test, is it "statistically significant" at the p<0.05 level? Why or why not?

sample = 1000 persons

false positive (5%) = 0.05 

false negative (0%) = 0.00

Need to use frequentist approach

The null hypothesis (H0) would be that the individual does not have the condition (e.g., HIV), and the alternative hypothesis (HA) would be that the individual does have the condition.

Globally, 0.7% of people in the world have HIV (https://www.who.int/data/gho/data/themes/hiv-aids#:~:text=Globally%2C%2039.9%20million%20%5B36.1–,considerably%20between%20countries%20and%20regions.)

In this case, the sample size is 1000 persons and the prevalence rate of HIV is 0.7% (0.7/100), such that the expected number of individuals with HIV is  1000 x (0.7/100)

Expected number of true positive= 7

False positive test
1000x(100-7/100)*0.05
=46.5 people would receive a false positive 

Person could only be 13% confident (7/46.5+7) that they have HIV based on this test, so only 7 of the 46 people who receive a positive test are actually infected. 

Exercise #2: What is the probability that if someone gets a positive test, that person is infected?

Bayesian Approach; Globally, 0.7% of people in the world have HIV (https://www.who.int/data/gho/data/themes/hiv-aids#:~:text=Globally%2C%2039.9%20million%20%5B36.1–,considerably%20between%20countries%20and%20regions.)

P(Positive∣Infected) = 1 person (no false negatives) 

P(Infected) = 0.007

P(Positive∣Not Infected)=0.05

P(Not Infected)= 1-P(infected)=0.993

P(Positive)=P(Positive∣Infected)×P(Infected)+P(Positive∣Not Infected)×P(Not Infected) 

P(Positive)=(1×0.007)+(0.05×0.993)=0.0567

Bayes' theorem:  P(Infected∣Positive)=1×0.007/0.0567≈0.12

The probability that the person with a positive test actually has HIV is around 12% 
