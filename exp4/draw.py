"""实验四问题一弃用的绘图函数

"""

import numpy as np
import matplotlib.pyplot as plt

def visualize_solutions(x_int, y_int, z_int, x_cont, y_cont, z_cont):
    """
    可视化线性规划问题的整数解和连续解（在同一图中）
    """
    # 创建画布
    plt.figure(figsize=(10, 6))
    plt.rcParams.update({
        "font.sans-serif": "SimHei",
        "axes.unicode_minus": False,
        "text.usetex": True,
        "text.latex.preamble": r"\usepackage{CJK}",
        })

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
    plt.fill_between(
        x,
        0,
        y_upper,
        where=x_mask,
        alpha=0.3,
        color="skyblue",
        label=r"\begin{CJK}{UTF8}{song}可行域\end{CJK}",
        zorder=1,
    )

    # 绘制约束边界
    plt.plot(x, y1, "r-", label=r"\begin{CJK}{UTF8}{song}原料约束：\end{CJK}$6x + 5y = 60$", zorder=2)
    plt.plot(x, y2, "g-", label=r"\begin{CJK}{UTF8}{song}工人约束:\end{CJK}$10x + 20y = 150$", zorder=2)
    plt.axvline(x=8, color="purple", linestyle="-", label=r"\begin{CJK}{UTF8}{song}产量限制:\end{CJK} $x = 8$", zorder=2)
    plt.axhline(y=0, color="black", linestyle="-", zorder=2)
    plt.axvline(x=0, color="black", linestyle="-", zorder=2)

    # 绘制整数最优解点
    plt.scatter(
        [x_int],
        [y_int],
        color="red",
        s=100,
        marker="*",
        zorder=5,
        label=rf"\begin{{CJK}}{{UTF8}}{{song}}整数规划最优解 $({x_int:.0f}, {y_int:.0f})$ $z={z_int:.2f}$万元\end{{CJK}}",
    )

    # 绘制连续最优解点
    plt.scatter(
        [x_cont],
        [y_cont],
        color="blue",
        s=100,
        marker="o",
        zorder=5,
        label=rf"\begin{{CJK}}{{UTF8}}{{song}}连续规划最优解 $({x_cont:.2f}, {y_cont:.2f})$ $z={z_cont:.2f}$万元\end{{CJK}}",
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
    plt.xlabel(r"\begin{CJK}{UTF8}{song}甲饮料产量 $x$ (百箱)\end{CJK}")
    plt.ylabel(r"\begin{CJK}{UTF8}{song}乙饮料产量 $y$ (百箱)\end{CJK}")
    plt.title(r"\begin{CJK}{UTF8}{song}饮料生产规划问题的图解 - 整数规划与连续规划对比\end{CJK}")
    plt.grid(True)
    plt.legend()

    # 保存图像
    plt.savefig("outputs/4/problem1_solutions_comparison.png", dpi=300, bbox_inches="tight")
    plt.show()