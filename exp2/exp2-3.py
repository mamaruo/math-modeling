import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

def draw_sphere_and_cylinder_interactive():
    """
    交互式绘制球面 x^2+y^2+z^2=1 和圆柱面 x^2+y^2=x
    两个图形绘制在同一个 figure 的两个子图中。
    """
    plt.ion()
    fig = plt.figure(figsize=(12, 6))

    # 绘制球面（单位球）
    ax1 = fig.add_subplot(1, 2, 1, projection="3d")
    u = np.linspace(0, np.pi, 50)
    v = np.linspace(0, 2 * np.pi, 50)
    U, V = np.meshgrid(u, v)
    X = np.sin(U) * np.cos(V)
    Y = np.sin(U) * np.sin(V)
    Z = np.cos(U)
    ax1.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8)
    ax1.set_box_aspect((1,1,1))  # 添加此行调整球体比例
    ax1.set_title("单位球面: x²+y²+z²=1")
    ax1.set_xlabel("X")
    ax1.set_ylabel("Y")
    ax1.set_zlabel("Z")

    # 绘制圆柱面: x^2+y^2=x  => (x-0.5)^2+y^2=0.25
    ax2 = fig.add_subplot(1, 2, 2, projection="3d")
    theta = np.linspace(0, 2 * np.pi, 50)
    z = np.linspace(-1, 1, 50)
    Theta, Zc = np.meshgrid(theta, z)
    Xc = 0.5 + 0.5 * np.cos(Theta)
    Yc = 0.5 * np.sin(Theta)
    ax2.plot_surface(Xc, Yc, Zc, cmap="plasma", alpha=0.8)
    ax2.set_title("圆柱面: (x-0.5)²+y²=0.25")
    ax2.set_xlabel("X")
    ax2.set_ylabel("Y")
    ax2.set_zlabel("Z")

    plt.show()
    input("交互模式已启动，按回车键继续...")  # 保持窗口打开

def draw_sphere_and_cylinder_static(save_path: str):
    """
    绘制球面和圆柱面，并以不同视角分别输出静态图片。
    使用subplot绘制四个视角的图形。
    """
    processed_save_path = Path(save_path)
    # 定义视角列表，每个元素为 (elev, azim)
    angles = [(20, 30), (40, 60), (60, 90), (80, 120)]
    
    # 生成球面数据（单位球）
    u = np.linspace(0, np.pi, 50)
    v = np.linspace(0, 2 * np.pi, 50)
    U, V = np.meshgrid(u, v)
    X = np.sin(U) * np.cos(V)
    Y = np.sin(U) * np.sin(V)
    Z = np.cos(U)
    
    # 生成圆柱面数据: (x-0.5)²+y²=0.25, z∈[-1,1]
    theta = np.linspace(0, 2 * np.pi, 50)
    z_c = np.linspace(-1, 1, 50)
    Theta, Zc = np.meshgrid(theta, z_c)
    Xc = 0.5 + 0.5 * np.cos(Theta)
    Yc = 0.5 * np.sin(Theta)
    
    # 绘制球面的四个视角
    fig_sphere, axs_sphere = plt.subplots(2, 2, figsize=(10, 9), subplot_kw={"projection": "3d"})
    fig_sphere.suptitle("不同角度观察单位球面")
    
    # 增加垂直间距
    plt.subplots_adjust(hspace=0.4)
    
    # 绘制球面
    for (i, j), (elev, azim) in zip([(0, 0), (0, 1), (1, 0), (1, 1)], angles):
        ax = axs_sphere[i, j]
        surf = ax.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8)
        ax.set_title(f"视角：仰角={elev}°, 方位角={azim}°")
        ax.set_xlabel("X轴")
        ax.set_ylabel("Y轴")
        ax.set_zlabel("Z轴")
        ax.set_box_aspect((1, 1, 1))  # 保持比例一致
        ax.view_init(elev=elev, azim=azim)
    
    plt.savefig(processed_save_path / "球面的各个角度.png", dpi=300)
    plt.close(fig_sphere)
    
    # 绘制圆柱面的四个视角
    fig_cylinder, axs_cylinder = plt.subplots(2, 2, figsize=(10, 9), subplot_kw={"projection": "3d"})
    fig_cylinder.suptitle("不同角度观察圆柱面")
    
    # 增加垂直间距
    plt.subplots_adjust(hspace=0.4)
    
    # 绘制圆柱面
    for (i, j), (elev, azim) in zip([(0, 0), (0, 1), (1, 0), (1, 1)], angles):
        ax = axs_cylinder[i, j]
        surf = ax.plot_surface(Xc, Yc, Zc, cmap="plasma", alpha=0.8)
        ax.set_title(f"视角：仰角={elev}°, 方位角={azim}°")
        ax.set_xlabel("X轴")
        ax.set_ylabel("Y轴")
        ax.set_zlabel("Z轴")
        ax.set_box_aspect((1, 1, 1))  # 保持比例一致
        ax.view_init(elev=elev, azim=azim)
    
    plt.savefig(processed_save_path / "圆柱面的各个角度.png", dpi=300)
    plt.close(fig_cylinder)

def chinese_fix():
    """修复matplotlib中文显示问题"""
    plt.rcParams["font.family"] = "Microsoft YaHei"
    plt.rcParams["axes.unicode_minus"] = False

if __name__ == "__main__":
    chinese_fix()
    # 调用交互式绘图函数
    draw_sphere_and_cylinder_interactive()
    # 输出静态图像到 outputs 目录
    draw_sphere_and_cylinder_static("outputs")
