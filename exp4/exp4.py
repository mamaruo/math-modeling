import pulp
import matplotlib.pyplot as plt
import numpy as np


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

    # 返回结果以便可视化
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

    # 返回结果以便可视化
    return x.value(), y.value(), pulp.value(problem.objective)


def visualize_solutions(x_int, y_int, z_int, x_cont, y_cont, z_cont):
    """
    可视化线性规划问题的整数解和连续解（在同一图中）
    """
    # 创建画布
    plt.figure(figsize=(10, 6))
    plt.rcParams["font.sans-serif"] = ["SimHei"]
    plt.rcParams["axes.unicode_minus"] = False

    # 定义区域范围
    x = np.linspace(0, 10, 1000)
    
    # 计算各约束下的y值
    y1 = (60 - 6 * x) / 5  # 原料约束: 6x + 5y <= 60
    y2 = (150 - 10 * x) / 20  # 工人约束: 10x + 20y <= 150
    
    # 应用x的约束: x <= 8
    x_mask = x <= 8
    
    # 计算可行域上界
    y_upper = np.minimum(y1, y2)
    y_upper[~x_mask] = 0  # 将x>8的区域设置为0（不可行）
    
    # 确保y非负
    y_upper = np.maximum(y_upper, 0)
    
    # 绘制可行域（确保在坐标轴底层）
    plt.fill_between(x, 0, y_upper, where=x_mask, alpha=0.3, color="skyblue", label="可行域", zorder=1)
    
    # 绘制约束边界
    plt.plot(x, y1, "r-", label="原料约束: 6x + 5y = 60", zorder=2)
    plt.plot(x, y2, "g-", label="工人约束: 10x + 20y = 150", zorder=2)
    plt.axvline(x=8, color="purple", linestyle='-', label="产量限制: x = 8", zorder=2)
    plt.axhline(y=0, color="black", linestyle='-', zorder=2)
    plt.axvline(x=0, color="black", linestyle='-', zorder=2)

    # 绘制整数最优解点
    plt.scatter(
        [x_int],
        [y_int],
        color="red",
        s=100,
        marker="*",
        zorder=5,
        label=f"整数规划最优解 ({x_int:.0f}, {y_int:.0f}) z={z_int:.2f}万元",
    )

    # 绘制连续最优解点
    plt.scatter(
        [x_cont],
        [y_cont],
        color="blue",
        s=100,
        marker="o",
        zorder=5,
        label=f"连续规划最优解 ({x_cont:.2f}, {y_cont:.2f}) z={z_cont:.2f}万元",
    )

    # 绘制一些目标函数的等值线
    z_values = [20, 40, 60, 80, z_int, z_cont]
    z_values = sorted(list(set([round(z, 2) for z in z_values])))  # 去重并排序
    for z in z_values:
        # 目标函数: z = 10x + 9y -> y = (z - 10x) / 9
        y_z = (z - 10 * x) / 9
        plt.plot(x, y_z, "b--", alpha=0.3, zorder=3)
        # 在x=4位置的点上添加z值标签
        idx = np.abs(x - 4).argmin()
        if y_z[idx] > 0 and y_z[idx] < 10:
            plt.text(4, y_z[idx], f"z={z}", zorder=4)

    # 设置图表属性
    plt.xlim(0, 10)
    plt.ylim(0, 10)
    plt.xlabel("甲饮料产量 x (百箱)")
    plt.ylabel("乙饮料产量 y (百箱)")
    plt.title("饮料生产规划问题的图解 - 整数规划与连续规划对比")
    plt.grid(True)
    plt.legend()

    # 保存图像
    plt.savefig("problem1_solutions_comparison.png", dpi=300, bbox_inches="tight")
    plt.show()


if __name__ == "__main__":
    # 求解整数规划问题
    print("===== 整数线性规划求解 =====")
    x_int, y_int, z_int = solve_problem_1_integer()

    # 求解连续线性规划问题
    print("\n===== 连续线性规划求解(对比) =====")
    x_cont, y_cont, z_cont = solve_problem_1_continuous()

    # 对比结果
    print(f"\n对比: 整数规划最大利润={z_int}万元, 连续规划最大利润={z_cont}万元")
    print(f"利润差额: {z_cont - z_int:.4f}万元")

    # 将两个解在同一图中可视化
    visualize_solutions(x_int, y_int, z_int, x_cont, y_cont, z_cont)
