---
title: 'Machine_Learning'
date: 2024-07-01T01:50:13+02:00
draft: true
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

# Basic

## Statistical Supervised Learning in a nutshell

![image-20240410035701400](./index.assets/image-20240410035701400.png)

![image-20240410035907658](./index.assets/image-20240410035907658.png)

![image-20240410040141222](./index.assets/image-20240410040141222.png)

![image-20240410040418542](./index.assets/image-20240410040418542.png)

![image-20240410040826200](./index.assets/image-20240410040826200.png)
$$
d_{VC}(\text{hyperplane}) = d + 1
$$


**PAC** Probably Approximately Correct

Valiant introduced PAC learning. Galton introduced Linear Regression. Quinlan introduced the Decision Tree. Bayes introduced Bayes’ rule and Naïve-Bayes theorem.

Explanation: A concept is PAC learnable by L if L can output a hypothesis with error < epsilon. Hence the maximum error obtained by the hypothesis should be less than epsilon. Epsilon is usually 5% or 1%.

![image-20240410042259734](./index.assets/image-20240410042259734.png)

![image-20240410043039897](./index.assets/image-20240410043039897.png)

- Giving an upper bound to the size of the training set can **reduce overfitting**

![image-20240410043745150](./index.assets/image-20240410043745150.png)



![image-20240410044326867](./index.assets/image-20240410044326867.png)
$$
VC(H) \leq \log_2|H|
$$
VC dimension can work for infinite hypothesis space, better than PAC



## Trees and Ensemble

**ID3**

![image-20240410045824177](./index.assets/image-20240410045824177.png)![image-20240410045855811](./index.assets/image-20240410045855811.png)

![image-20240410050017145](./index.assets/image-20240410050017145.png)

- 最小化KL散度等同于最小化交叉熵
- 

![image-20240410050646116](./index.assets/image-20240410050646116.png)

![image-20240410051552237](./index.assets/image-20240410051552237.png)

![image-20240410051720249](./index.assets/image-20240410051720249.png)



![image-20240410052544336](./index.assets/image-20240410052544336.png)



- Boosting is not a heterogeneous ensemble but is a homogeneous ensemble.
- If the classifier is unstable which means it has high variance, then we cannot apply boosting. We can use bagging if the classifier is unstable. If the classifier is steady and straightforward (high bias), then we have to apply boosting.
- The success of AdaBoost is due to its property of increasing the margin.





## SVM

![image-20240410055000334](./index.assets/image-20240410055000334.png)



## N

![image-20240410055301431](./index.assets/image-20240410055301431.png)

![image-20240410055327100](./index.assets/image-20240410055327100.png)

![image-20240410055638544](./index.assets/image-20240410055638544.png)





**conv layer output**
$$
o = \left \lfloor \frac{i + 2p -k}{s} \right \rfloor + 1
$$

## Some MCQ

https://www.sanfoundry.com/1000-machine-learning-questions-answers/

https://github.com/SamBelkacem/AI-ML-cheatsheets

https://www.ctanujit.org/uploads/2/5/3/9/25393293/cheatsheets.pdf

- Machine learning is the autonomous acquisition of knowledge through the use of computer programs.
- 

Which algorithm is best suited for a binary classification problem?

a) K-nearest Neighbors
b) Decision Trees
c) Random Forest
d) Linear Regression