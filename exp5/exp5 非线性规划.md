# 实验五 非线性规划

## 实验目的及要求

1. 了解非线性规划的基本内容；
2. 掌握用数学软件包（MATLAB、LINGO、Python）求解非线性规划问题。

## 实验内容
1. 某厂向用户提供发动机，合同规定，第一、二、三季度末分别交货 $40$ 台、$60$ 台、$80$ 台．每季度的生产费用为 $f(x)=ax+bx^2$（元），其中 $x$ 是该季生产的台数。若交货后有剩余，可用于下季度交货，但需支付存储费，每台每季度 $c$ 元。已知工厂每季度最大生产能力为 $100$ 台，第一季度开始时无存货，设 $a=50$、$b=0.2$、$c=4$，问工厂应如何安排生产计划，才能既满足合同又使总费用最低。讨论 $a$、$b$、$c$ 变化对计划的影响，并作出合理的解释。

2. 设某城市有某种物品的 $8$ 个需求点，第 $i$ 个需求点 $P_i$ 的坐标为 $(a_i, b_i)$，数值如下表。现打算建一个该物品的供应中心。受到城市条件的限制，该供应中心只能设在 $x$ 界于 $[4, 7]$，$y$ 界于 $[5, 9]$ 的范围之内。问该中心应建在何处到最远需求点的直线距离尽可能最小？

|       |   |   |   |    |    |    |   |    |
|:-----:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| $a_i$ | 2 | 3 | 4 | 5  | 2  | 4  | 6 | 9  |
| $b_i$ | 4 | 7 | 5 | 10 | 10 | 13 | 5 | 15 |
