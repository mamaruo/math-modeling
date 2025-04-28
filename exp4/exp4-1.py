"""实验四问题一：饮料生产规划问题

Author: mamaruo
Created: 2025-03-23
Last modified: 2025-04-27
"""

import pulp

def solve_problem_1_integer():
    """
    使用PuLP求解问题一的整数线性规划模型:

    max z = 10x + 9y
    s.t.
        6x + 5y <= 60
        10x + 20y <= 150
        x <= 8
        x, y >= 0
        x, y ∈ Z (整数约束)
    """
    # 创建整数线性规划问题
    problem = pulp.LpProblem("Drink_Production_Planning_Integer", pulp.LpMaximize)

    # 定义决策变量（百箱）- 整数变量
    x = pulp.LpVariable("x_drink_A", lowBound=0, cat=pulp.LpInteger)  # 甲饮料产量(整数)
    y = pulp.LpVariable("y_drink_B", lowBound=0, cat=pulp.LpInteger)  # 乙饮料产量(整数)

    # 设置目标函数（万元）
    problem += 10 * x + 9 * y, "Total_Profit"

    # 添加约束条件
    problem += 6 * x + 5 * y <= 60, "Material_Constraint"  # 原料约束
    problem += 10 * x + 20 * y <= 150, "Labor_Constraint"  # 工人约束
    problem += x <= 8, "Production_Limit_Constraint"  # 产量限制

    # 求解问题
    problem.solve()

    # 输出结果
    print("整数规划问题求解状态:", pulp.LpStatus[problem.status])
    print("\n整数最优解:")
    print(f"甲饮料产量 x = {int(x.value())} 百箱")
    print(f"乙饮料产量 y = {int(y.value())} 百箱")
    print(f"最大利润 z = {pulp.value(problem.objective)} 万元")

    # 验证约束条件
    print("\n约束条件验证:")
    print(f"原料使用：{6 * x.value() + 5 * y.value():.2f}/60 千克")
    print(f"工人使用：{10 * x.value() + 20 * y.value():.2f}/150 人")

    # 返回结果
    return x.value(), y.value(), pulp.value(problem.objective)


def solve_problem_1_continuous():
    """
    使用PuLP求解问题一的连续线性规划模型(用于对比):

    max z = 10x + 9y
    s.t.
        6x + 5y <= 60
        10x + 20y <= 150
        x <= 8
        x, y >= 0
    """
    # 创建线性规划问题
    problem = pulp.LpProblem("Drink_Production_Planning", pulp.LpMaximize)

    # 定义决策变量（百箱）
    x = pulp.LpVariable("x_drink_A", lowBound=0)  # 甲饮料产量
    y = pulp.LpVariable("y_drink_B", lowBound=0)  # 乙饮料产量

    # 设置目标函数（万元）
    problem += 10 * x + 9 * y, "Total_Profit"

    # 添加约束条件
    problem += 6 * x + 5 * y <= 60, "Material_Constraint"  # 原料约束
    problem += 10 * x + 20 * y <= 150, "Labor_Constraint"  # 工人约束
    problem += x <= 8, "Production_Limit_Constraint"  # 产量限制

    # 求解问题
    problem.solve()

    # 输出结果
    print("问题求解状态:", pulp.LpStatus[problem.status])
    print("\n最优解:")
    print(f"甲饮料产量 x = {x.value()} 百箱")
    print(f"乙饮料产量 y = {y.value()} 百箱")
    print(f"最大利润 z = {pulp.value(problem.objective)} 万元")

    # 验证约束条件
    print("\n约束条件验证:")
    print(f"原料使用：{6 * x.value() + 5 * y.value():.2f}/60 千克")
    print(f"工人使用：{10 * x.value() + 20 * y.value():.2f}/150 人")

    # 返回结果
    return x.value(), y.value(), pulp.value(problem.objective)


def solve_problem_1_optimized():
    """
    使用PuLP求解问题一的优化整数线性规划模型:
    
    max z = 0.1x + 0.09y
    s.t.
        0.06x + 0.05y <= 60
        0.1x + 0.2y <= 150
        x <= 800
        x, y >= 0
        x, y ∈ Z (整数约束)
        
    注：此模型直接使用"箱"作为单位，而不是"百箱"
    """
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
    print("优化模型求解状态:", pulp.LpStatus[prob.status])
    print("\n优化模型最优解:")
    print(f"甲饮料产量：{int(pulp.value(x))} 箱")
    print(f"乙饮料产量：{int(pulp.value(y))} 箱")
    print(f"最大利润：{pulp.value(prob.objective)} 万元")

    # 验证约束条件
    print("\n约束条件验证：")
    print(f"原料使用：{0.06 * pulp.value(x) + 0.05 * pulp.value(y):.2f}/60 千克")
    print(f"工人使用：{0.1 * pulp.value(x) + 0.2 * pulp.value(y):.2f}/150 人")

    # 返回结果
    return pulp.value(x), pulp.value(y), pulp.value(prob.objective)


if __name__ == "__main__":
    # 求解整数规划问题
    print("===== 整数线性规划求解 =====")
    x_int, y_int, z_int = solve_problem_1_integer()

    # 求解连续线性规划问题
    print("\n===== 连续线性规划求解(对比) =====")
    x_cont, y_cont, z_cont = solve_problem_1_continuous()

    # 求解优化后的整数规划问题
    print("\n===== 优化后的整数线性规划求解 =====")
    x_opt, y_opt, z_opt = solve_problem_1_optimized()

    # 对比结果
    print("\n===== 结果对比 =====")
    print(f"原整数规划最大利润: {z_int}万元")
    print(f"连续规划最大利润: {z_cont}万元")
    print(f"优化后整数规划最大利润: {z_opt}万元")
    print(f"连续与原整数规划利润差额: {z_cont - z_int:.4f}万元")
    print(f"优化后与原整数规划利润差额: {z_opt - z_int:.4f}万元")