% filepath: /C:/Users/mamaruo/Documents/GitHub/math-modeling/exp1/exp1.m
%{
实验一的代码文件。

用于验证学生身份的MD5 hash: 5a4e63a9fb3f797ed25119f3538a5484

Author: mamaruo
Created: 2025-02-24
Last modified: 2025-03-09
%}

function exp1(stu_id, stu_name, save_path)
    % 主函数，作为函数选择器
    while true
        disp(['=========== 实验一函数选择器 ===========']);
        disp(['学生ID: ', stu_id]);
        disp(['学生姓名: ', stu_name]);
        disp(['保存路径: ', save_path]);
        disp('1. 冒泡排序');
        disp('2. 查找矩阵最大值');
        disp('3. 计算阶乘之和');
        disp('4. 弹跳球计算');
        disp('5. 计算函数值');
        disp('0. 退出程序');
        disp('=====================================');
        
        disp('请选择功能 (0-5): ');
        choice = input('');
        
        switch choice
            case 0
                disp('程序已退出。');
                break;
                
            case 1
                disp('===== 冒泡排序 =====');
                disp('请输入一维数组 (例如：[5,3,8,1,2]): ');
                input_array = input('');
                execute_bubble_sort(input_array);
                
            case 2
                disp('===== 查找矩阵最大值 =====');
                disp('请输入一个二维矩阵:');
                disp('矩阵 (例如：[1,2;3,4]): ');
                matrix = input('');
                execute_find_max(matrix);
                
            case 3
                disp('===== 计算阶乘之和 =====');
                disp('请输入n (默认20): ');
                n = input('');
                if isempty(n)
                    n = 20;
                end
                execute_sum_factorials(n);
                
            case 4
                disp('===== 弹跳球计算 =====');
                disp('请输入初始高度: ');
                initial_height = input('');
                disp('请输入弹跳次数 (默认10): ');
                times = input('');
                if isempty(times)
                    times = 10;
                end
                execute_ball_bounce(initial_height, times);
                
            case 5
                disp('===== 计算函数值 =====');
                disp('请输入x的值: ');
                x = input('');
                disp('请输入y的值: ');
                y = input('');
                
                % 检查x和y是否为符号变量
                if ~isa(x, 'sym')
                    x = sym(x);
                end
                if ~isa(y, 'sym')
                    y = sym(y);
                end
                
                result = calculate_function_value(x, y);
                disp(['f(', char(x), ',', char(y), ') = ', char(result)]);
                
            otherwise
                disp('无效选择，请重新输入！');
        end
        
        disp(' ');
        disp('按回车键继续...');
        input('');
        disp(' ');
    end
end

function execute_bubble_sort(input_array)
    % 执行冒泡排序并处理可能的错误
    if isempty(input_array)
        disp('输入数组为空');
        return;
    end
    
    if ndims(input_array) ~= 2 || min(size(input_array)) ~= 1
        disp('错误: 输入必须是一维数组');
        return;
    end
    
    result = bubble_sort(input_array);
    disp('排序结果:');
    disp(result);
end

function execute_find_max(matrix)
    % 执行查找最大值并处理可能的错误
    if isempty(matrix)
        disp('输入矩阵为空');
        return;
    end
    
    if ndims(matrix) ~= 2
        disp('错误: 输入必须是二维矩阵');
        return;
    end
    
    [max_val, coordinate] = find_max_in_matrix(matrix);
    disp(['最大值: ', num2str(max_val)]);
    disp(['坐标: [', num2str(coordinate(1)), ', ', num2str(coordinate(2)), ']']);
end

function execute_sum_factorials(n)
    % 执行阶乘之和计算并处理可能的错误
    if n < 0
        disp('错误: n必须为非负整数');
        return;
    end
    
    result = sum_of_factorials(n);
    % 使用sprintf格式化输出完整数字，不使用科学计数法
    formatted_result = sprintf('%.0f', result);
    disp(['1到', num2str(n), '的阶乘之和: ', formatted_result]);
end

function execute_ball_bounce(initial_height, times)
    % 执行弹跳球计算并处理可能的错误
    if initial_height < 0
        disp('错误: 初始高度不能为负数');
        return;
    end
    
    if times < 1
        disp('错误: 弹跳次数不能小于1');
        return;
    end
    
    [distance, final_height] = ball_bounce(initial_height, times);
    % 使用sprintf格式化输出完整浮点数结果
    formatted_distance = sprintf('%.15g', distance);
    formatted_final_height = sprintf('%.15g', final_height);
    disp(['总距离: ', formatted_distance]);
    disp(['第', num2str(times), '次弹跳高度: ', formatted_final_height]);
end

function sorted_array = bubble_sort(one_d_array)
    % 对一维数组冒泡排序。
    %
    % 参数:
    %   one_d_array: 一维数组。
    %
    % 返回值:
    %   sorted_array: 排序后的一维数组。
    
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
    
    if nargin < 1
        n = 20;
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
    
    if nargin < 2
        times = 10;
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