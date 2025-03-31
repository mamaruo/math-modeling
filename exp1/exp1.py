"""
实验一的代码文件。

用于验证学生身份的MD5 hash: 5a4e63a9fb3f797ed25119f3538a5484

Author: mamaruo
Created: 2025-02-24
Last modified: 2025-03-24
"""

from typing import Tuple, Union

import numpy as np
import numpy.typing as npt

# 类型注解，表示一个包含两个 int 的 numpy 数组
Coordinate = np.ndarray[Tuple[2], int]


def bubble_sort(one_d_array: npt.NDArray[np.float64]) -> npt.NDArray[np.float64]:
    """对一维数组冒泡排序。

    Args:
        one_d_array (npt.NDArray[np.float64]): 一维数组。

    Returns:
        npt.NDArray[np.float64]: 排序后的一维数组。

    Raises:
        ValueError: 如果输入数组不是一维的。
    """
    if one_d_array.ndim != 1:
        raise ValueError("The input array must be one-dimensional.")
    n = len(one_d_array)
    for i in range(n):
        for j in range(n - i - 1):
            if one_d_array[j] > one_d_array[j + 1]:
                one_d_array[j], one_d_array[j + 1] = one_d_array[j + 1], one_d_array[j]
    return one_d_array


def find_max_in_matrix(
    matrix: npt.NDArray[np.float64],
) -> Tuple[Union[float, int], Coordinate]:
    """查找二维numpy数组中的最大值及其坐标。

    Args:
        matrix (npt.NDArray[np.float64]): 浮点数类型的二维numpy数组。

    Returns:
        Tuple[Union[float, int], Coordinate]: 包含以下内容的元组：
            - 矩阵中的最大值（浮点数或整数）
            - 最大值所在的坐标元组(行, 列)

    Raises:
        ValueError: 如果输入矩阵不是二维的。
    """
    if matrix.ndim != 2:
        raise ValueError("输入矩阵需为二维")

    max = np.max(matrix)
    index = np.argmax(matrix)
    coordinate = np.unravel_index(index, matrix.shape)

    return max, coordinate


def sum_of_factorials(n: int = 20) -> int:
    """计算1~n的阶乘之和。

    Args:
        n (int, optional): 求和上限。默认为20。

    Raises:
        ValueError: 如果n为负数。

    Returns:
        int: 阶乘之和。
    """
    if n < 0:
        raise ValueError("n必须为非负整数")

    total = 0
    factorial = 1

    for i in range(1, n + 1):
        factorial *= i
        total += factorial

    return total


def ball_bounce(
    initial_height: Union[float, int] = 100, times: int = 10
) -> Tuple[Union[float, int], Union[float, int]]:
    """计算球从初始高度落下后第times次弹跳的高度和总距离。

    Args:
        initial_height (Union[float, int]): 初始高度。Defaults to 100.
        times (int, optional): 弹跳次数. Defaults to 10.

    Returns:
        Tuple[Union[float, int], Union[float, int]]: 包含以下内容的元组：
            - 总距离
            - 第times次弹跳的高度

    Raises:
        ValueError: 如果初始高度为负数、弹跳次数为负数。
    """
    if initial_height < 0:
        raise ValueError("初始高度不能为负数")
    if times < 1:
        raise ValueError("弹跳次数不能小于1")

    factor = 0.5**times
    distance = 4 * initial_height * (1 - factor) - initial_height
    height = initial_height * factor

    return distance, height


def calculate_function_value(x: Union[float, int], y: Union[float, int]) -> float:
    """计算函数 f(x,y) = x^2 + sin(xy) + 2y 的值

    Args:
        x (Union[float, int]): x的值
        y (Union[float, int]): y的值

    Returns:
        float: 函数值
    """
    return x**2 + np.sin(x * y) + 2 * y


if __name__ == "__main__":
    print(bubble_sort(np.array([3, 2, 1, 4, 5])))
    print(find_max_in_matrix(np.array([[1, 2, 3], [4, 51, 6], [7, 8, 9]])))
    print(sum_of_factorials())
    print(ball_bounce())
    print(calculate_function_value(np.pi, 4))
