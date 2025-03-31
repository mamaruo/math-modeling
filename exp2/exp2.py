"""
实验二的代码文件。

Author: mamaruo
Created: 2025-03-03
Last modified: 2025-03-31
"""

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.legend_handler import HandlerTuple
from pathlib import Path


def chinese_fix():
    """修复matplotlib中文显示问题"""
    plt.rcParams["font.family"] = "Microsoft YaHei"
    plt.rcParams["axes.unicode_minus"] = False


def draw_sin_and_cos(stu_id: str, stu_name: str, save_path: str):
    """绘制正弦和余弦函数图像，并保存到指定路径。

    Args:
        stu_id (str): 学号，用于在图像标题中显示。
        stu_name (str): 姓名，用于在图像标题中显示。
        save_path (str): 保存图像目录，不包含文件名。
    """
    chinese_fix()
    plt.figure()  # 创建新图表，避免覆盖
    plt.title(f"正弦函数和余弦函数 {stu_id} {stu_name}")

    plt.xlim(-2 * np.pi, 2 * np.pi)  # 设置绘图区x轴范围
    plt.ylim(-1.5, 1.5)  # 设置绘图区y轴范围

    ax = plt.gca()
    for spine in ax.spines.values():
        spine.set_linewidth(1.0)

    ax.tick_params(
        axis="both",
        direction="in",
        width=1.0,
        top=True,
        right=True,
        pad=7,  # 增加label的距离
    )  # 设置刻度(tick)的样式，向内，四周都显示
    plt.grid(
        True, which="both", linestyle="-", color="gray", alpha=0.5, linewidth=0.5
    )  # 设置灰色实线网格，不透明度50%，线宽0.5
    plt.xlabel("自变量（X）")  # 设置轴标签
    plt.ylabel("函数值（Y）")
    ax.yaxis.set_major_formatter(
        plt.FuncFormatter(lambda val, pos: "{:g}".format(val))
    )  # 修改y轴刻度标签格式

    x_ticks = np.arange(
        -2 * np.pi, 2 * np.pi + 1, np.pi
    )  # 设置x轴刻度值；+1是为了包含2π
    plt.xticks(x_ticks, ["-2π", "-π", "0", "π", "2π"])  # 设置x轴刻度标签

    # 生成绘图用的值序列
    dense_seq = np.linspace(-2 * np.pi, 2 * np.pi, 1000)
    sparse_seq = np.linspace(-2 * np.pi, 2 * np.pi, 100)

    # 绘制红色的正弦函数
    sin_line = plt.plot(dense_seq, np.sin(dense_seq), "r--", linewidth=2, zorder=5)[0]
    sin_scatter = plt.plot(
        sparse_seq,
        np.sin(sparse_seq),
        "o",
        markersize=6,
        markeredgecolor="red",
        markerfacecolor="none",  # 空心圆点
        markeredgewidth=1.5,  # 线宽
        clip_on=False,  # 不受边界限制
        zorder=5,  # 确保在网格线上方，且被下面的余弦函数覆盖
    )[0]

    # 绘制蓝色余弦函数
    cos_line = plt.plot(dense_seq, np.cos(dense_seq), "b--", linewidth=2, zorder=5)[0]
    cos_scatter = plt.plot(
        sparse_seq,
        np.cos(sparse_seq),
        "b+",
        markersize=6,
        markeredgewidth=1.5,
        clip_on=False,
        zorder=6,  # 确保在网格线上方，且覆盖上面的正弦函数
    )[0]

    # 混合图例
    plt.legend(
        [(sin_scatter, sin_line), (cos_scatter, cos_line)],
        ["y=sin(x)", "y=cos(x)"],
        handler_map={tuple: HandlerTuple(ndivide=1)},
        loc="upper right",
    )

    plt.savefig(Path(save_path) / "sin_cos图像.png", dpi=300)
    plt.show()


def draw_heart_saddle(save_path: str):
    """
    绘制心形线和马鞍面

    Args:
        save_path: 保存图片的目录，不含文件名
    """
    chinese_fix()
    processed_save_path = Path(save_path)
    fig = plt.figure(figsize=(12, 5))
    fig.suptitle("心形线和马鞍面")

    # 心形线（极坐标）
    ax1 = fig.add_subplot(1, 2, 1, projection="polar")
    a = 1  # 心形线参数
    theta = np.linspace(0, 2 * np.pi, 1000)
    r = a * (1 - np.cos(theta))  # 心形线方程

    ax1.plot(theta, r, "r-", label="心形线: r = a(1-cos(θ))")
    ax1.set_title("心形线")
    ax1.grid(True)
    ax1.set_rticks([0.5, 1.0, 1.5, 2.0])  # 定制r轴刻度
    ax1.set_rlabel_position(45)  # 设置r标签的位置在45度
    ax1.legend(loc="upper right")

    # 马鞍面
    ax2 = fig.add_subplot(1, 2, 2, projection="3d")
    x = np.linspace(-2, 2, 50)
    y = np.linspace(-2, 2, 50)
    X, Y = np.meshgrid(x, y)
    Z = X**2 - Y**2  # 马鞍面方程

    surf = ax2.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8)
    ax2.set_title("马鞍面: z = x² - y²")
    ax2.set_xlabel("X轴")
    ax2.set_ylabel("Y轴")
    ax2.set_zlabel("Z轴")

    # 添加颜色条图例
    cbar = fig.colorbar(surf, ax=ax2, shrink=0.5, aspect=5)
    cbar.set_label("高度值")

    # 设置观察角度 (仰角, 方位角)
    ax2.view_init(elev=30, azim=45)

    plt.tight_layout()
    plt.savefig(processed_save_path / "心形线和马鞍面.png", dpi=300)
    plt.show()

    # 额外从不同角度观察马鞍面
    angles = [(20, 0), (40, 30), (60, 60), (80, 90)]
    fig, axs = plt.subplots(2, 2, figsize=(10, 9), subplot_kw={"projection": "3d"})
    fig.suptitle("不同角度观察马鞍面")
    
    # 增加垂直间距
    plt.subplots_adjust(hspace=0.4)

    # 绘制马鞍面
    for (i, j), (elev, azim) in zip([(0, 0), (0, 1), (1, 0), (1, 1)], angles):
        ax = axs[i, j]
        surf = ax.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8)
        ax.set_title(f"视角：仰角={elev}°, 方位角={azim}°")
        ax.set_xlabel("X轴")
        ax.set_ylabel("Y轴")
        ax.set_zlabel("Z轴")
        ax.view_init(elev=elev, azim=azim)
        ax.mouse_init(rotate_btn=None, zoom_btn=None)

    plt.savefig(processed_save_path / "马鞍面的各个角度", dpi=300)
    plt.show()


if __name__ == "__main__":
    draw_sin_and_cos("2023110224", "马若华", "outputs")
    # draw_heart_saddle("outputs")
