% filepath: /C:/Users/mamaruo/Documents/GitHub/math-modeling/exp1/exp1.m
%{
实验一的代码文件。

用于验证学生身份的MD5 hash: 5a4e63a9fb3f797ed25119f3538a5484

Author: mamaruo
Created: 2025-02-24
Last modified: 2025-03-03
%}

function exp1()
    % 主函数，作为函数选择器
    while true
        disp('=========== 实验一函数选择器 ===========');
        disp('1. 冒泡排序');
        disp('2. 查找矩阵最大值');
        disp('3. 计算阶乘之和');
        disp('4. 弹跳球计算');
        disp('5. 计算函数值');
        disp('0. 退出程序');
        disp('=====================================');
        
        choice = input('请选择功能 (0-5): ');
        
        switch choice
            case 0
                disp('程序已退出。');
                break;
                
            case 1
                disp('===== 冒泡排序 =====');
                input_array = input('请输入一维数组 (例如：[5,3,8,1,2]): ');
                try
                    result = bubble_sort(input_array);
                    disp('排序结果:');
                    disp(result);
                catch ME
                    disp(['错误: ', ME.message]);
                end
                
            case 2
                disp('===== 查找矩阵最大值 =====');
                disp('请输入一个二维矩阵:');
                try
                    matrix = input('矩阵 (例如：[1,2;3,4]): ');
                    [max_val, coordinate] = find_max_in_matrix(matrix);
                    disp(['最大值: ', num2str(max_val)]);
                    disp(['坐标: [', num2str(coordinate(1)), ', ', num2str(coordinate(2)), ']']);
                catch ME
                    disp(['错误: ', ME.message]);
                end
                
            case 3
                disp('===== 计算阶乘之和 =====');
                n = input('请输入n (默认20): ');
                if isempty(n)
                    n = 20;
                end
                try
                    result = sum_of_factorials(n);
                    disp(['1到', num2str(n), '的阶乘之和: ', num2str(result)]);
                catch ME
                    disp(['错误: ', ME.message]);
                end
                
            case 4
                disp('===== 弹跳球计算 =====');
                initial_height = input('请输入初始高度: ');
                times = input('请输入弹跳次数 (默认10): ');
                if isempty(times)
                    times = 10;
                end
                try
                    [distance, final_height] = ball_bounce(initial_height, times);
                    disp(['总距离: ', num2str(distance)]);
                    disp(['第', num2str(times), '次弹跳高度: ', num2str(final_height)]);
                catch ME
                    disp(['错误: ', ME.message]);
                end
                
            case 5
                disp('===== 计算函数值 =====');
                x = input('请输入x的值: ');
                y = input('请输入y的值: ');
                result = calculate_function_value(x, y);
                disp(['f(', num2str(x), ',', num2str(y), ') = ', num2str(result)]);
                
            otherwise
                disp('无效选择，请重新输入！');
        end
        
        disp(' ');
        input('按回车键继续...');
        disp(' ');
    end
end

function sorted_array = bubble_sort(one_d_array)
    % 对一维数组冒泡排序。
    %
    % 参数:
    %   one_d_array: 一维数组。
    %
    % 返回值:
    %   sorted_array: 排序后的一维数组。
    %
    % 异常:
    %   如果输入数组不是一维的，则抛出错误。
    
    if ndims(one_d_array) ~= 2 || min(size(one_d_array)) ~= 1
        error('The input array must be one-dimensional.');
    end
    
    sorted_array = one_d_array;
    n = length(sorted_array);
    for i = 1:n
        for j = 1:n-i
            if sorted_array(j) > sorted_array(j+1)
                temp = sorted_array(j);
                sorted_array(j) = sorted_array(j+1);
                sorted_array(j+1) = temp;
            end
        end
    end
end

function [max_val, coordinate] = find_max_in_matrix(matrix)
    % 查找二维矩阵中的最大值及其坐标。
    %
    % 参数:
    %   matrix: 浮点数类型的二维矩阵。
    %
    % 返回值:
    %   max_val: 矩阵中的最大值（浮点数或整数）
    %   coordinate: 最大值所在的坐标[行, 列]
    %
    % 异常:
    %   如果输入矩阵不是二维的，则抛出错误。
    
    if ndims(matrix) ~= 2
        error('输入矩阵需为二维');
    end
    
    max_val = max(matrix(:));
    [row, col] = find(matrix == max_val, 1, 'first');
    coordinate = [row, col];
end

function result = sum_of_factorials(n)
    % 计算1~n的阶乘之和。
    %
    % 参数:
    %   n: 求和上限。默认为20。
    %
    % 返回值:
    %   result: 阶乘之和。
    %
    % 异常:
    %   如果n为负数，则抛出错误。
    
    if nargin < 1
        n = 20;
    end
    
    if n < 0
        error('n必须为非负整数');
    end
    
    total = 0;
    factorial_val = 1;
    
    for i = 1:n
        factorial_val = factorial_val * i;
        total = total + factorial_val;
    end
    
    result = total;
end

function [distance, final_height] = ball_bounce(initial_height, times)
    % 计算球从初始高度落下后第times次弹跳的高度和总距离。
    %
    % 参数:
    %   initial_height: 初始高度。
    %   times: 弹跳次数。默认为10。
    %
    % 返回值:
    %   distance: 总距离
    %   final_height: 第times次弹跳的高度
    %
    % 异常:
    %   如果初始高度为负数、弹跳次数为负数，则抛出错误。
    
    if nargin < 2
        times = 10;
    end
    
    if initial_height < 0
        error('初始高度不能为负数');
    end
    if times < 1
        error('弹跳次数不能小于1');
    end
    
    factor = 0.5^times;
    distance = 4 * initial_height * (1 - factor) - initial_height;
    final_height = initial_height * factor;
end

function result = calculate_function_value(x, y)
    % 计算函数 f(x,y) = x^2 + sin(xy) + 2y 的值
    %
    % 参数:
    %   x: x的值
    %   y: y的值
    %
    % 返回值:
    %   result: 函数值
    
    result = x^2 + sin(x * y) + 2 * y;
end