"""问题一优化后的模型"""

import pulp

# 创建优化问题
prob = pulp.LpProblem("饮料生产优化", pulp.LpMaximize)

# 定义决策变量（x和y代表生产箱数，必须为整数）
x = pulp.LpVariable("x", 0, 800, pulp.LpInteger)
y = pulp.LpVariable("y", 0, None, pulp.LpInteger)

# 目标函数（单位：万元/箱）
prob += 0.1 * x + 0.09 * y

# 约束条件
prob += 0.06 * x + 0.05 * y <= 60  # 原料约束
prob += 0.1 * x + 0.2 * y <= 150   # 工人约束
prob += x <= 800                    # 甲饮料产量限制

# 求解
prob.solve()

# 输出结果
print("求解状态:", pulp.LpStatus[prob.status])
print("甲饮料产量：", int(pulp.value(x)), "箱")
print("乙饮料产量：", int(pulp.value(y)), "箱")
print("最大利润：", pulp.value(prob.objective), "万元")

# 验证约束条件
print("\n约束条件验证：")
print(f"原料使用：{0.06 * pulp.value(x) + 0.05 * pulp.value(y):.2f}/60 千克")
print(f"工人使用：{0.1 * pulp.value(x) + 0.2 * pulp.value(y):.2f}/150 人")
