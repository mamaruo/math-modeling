% 实验三：图像处理和符号运算

function exp3()
% EXP3 - 主函数，用于选择并执行功能
%
% 本函数提供交互式界面，允许用户选择以下功能：
%   1. 图像处理1 - 旋转、拼接和提取蓝色环
%   2. 图像处理2 - 边缘检测、锐化和模糊化处理
%   3. 符号运算 - 极限、导数、积分和多项式展开
%   4. 全部功能
%
% 用户还可以控制是否显示处理结果和是否保存结果到文件

    clear;
    close all;
    clc;

    % 读取配置文件
    try
        % 获取当前脚本所在的目录路径
        current_dir = fileparts(mfilename('fullpath'));
        % 向上一层目录获取根目录
        root_dir = fileparts(current_dir);
        % 构建配置文件的完整路径
        config_path = fullfile(root_dir, 'config.json');
        
        % 读取JSON配置文件
        config_file = fileread(config_path);
        config = jsondecode(config_file);
        
        % 获取工作目录
        work_dir = config.work_dir;
        
        % 切换到指定的工作目录
        cd(work_dir);
        fprintf('已切换到工作目录: %s\n', work_dir);
    catch e
        fprintf('读取配置文件出错: %s\n', e.message);
    end

    while true
        % 显示功能菜单
        disp('=== 实验三功能选择 ===');
        disp('1. 图像处理1 - 旋转、拼接和提取蓝色环');
        disp('2. 图像处理2 - 边缘检测、锐化和模糊化处理');
        disp('3. 符号运算 - 极限、导数、积分和多项式展开');
        disp('4. 执行全部功能');
        disp('0. 退出');
        
        % 获取用户选择
        disp('请输入功能编号 (0-4): ');
        choice = input('');
        
        % 如果用户选择退出，则直接返回
        if choice == 0
            disp('程序已退出');
            return;
        end
        
        % 检查选择是否有效
        if ~ismember(choice, [1, 2, 3, 4])
            disp('无效的选择，请输入0-4之间的数字');
            continue;
        end
        
        % 询问是否显示结果
        show_results = ask_yes_no('是否显示处理结果？包括控制台回显和图片窗口显示。 (y/n)：');
        
        % 询问是否保存结果
        save_results = ask_yes_no('是否保存处理结果到文件? (y/n)：');
        
        % 根据选择执行相应功能
        switch choice
            case 1
                % 执行图像处理1
                img_process1(show_results, save_results);
            case 2
                % 执行图像处理2
                img_process2(show_results, save_results);
            case 3
                % 执行符号运算
                symbolic_math(show_results, save_results);
            case 4
                % 执行全部功能
                img_process1(show_results, save_results);
                img_process2(show_results, save_results);
                symbolic_math(show_results, save_results);
                disp('执行完全部功能，即将退出。');
                return;
        end
        
        disp('功能执行完毕!');
    end
end


function answer = ask_yes_no(prompt)
% ASK_YES_NO - 获取用户的是/否回答
%
% 语法:
%   answer = ask_yes_no(prompt)
%
% 输入参数:
%   prompt - 提示用户的字符串
%
% 输出参数:
%   answer - 逻辑值，true表示"是"，false表示"否"

    while true
        disp(prompt);
        user_input = input('', 's');
        if isempty(user_input)
            user_input = 'y';  % 默认为"是"
        end
        if strcmpi(user_input(1), 'y')
            answer = true;
            break;
        elseif strcmpi(user_input(1), 'n')
            answer = false;
            break;
        else
            disp('请输入 y(是) 或 n(否)');
        end
    end
end

% ---------------------------------------------
function img_process1(show_images, save_images)
% IMG_PROCESS1 - 图像处理函数1
%
% 本函数实现以下图像处理功能：
%   1. 将输入图像分别进行顺时针和逆时针90度旋转
%   2. 将图像复制八份并按2×4布局拼接
%   3. 提取图像中的蓝色环，生成白底蓝环图像
%
% 语法:
%   img_process1(show_images, save_images)
%
% 输入参数:
%   show_images - 逻辑值，控制是否显示处理结果
%   save_images - 逻辑值，控制是否保存处理结果到文件
%
% 输入文件:
%   - exp3/实验3-1图.png
%
% 输出文件:
%   - outputs/3/实验3-1图_顺时针旋转90度.png
%   - outputs/3/实验3-1图_逆时针旋转90度.png
%   - outputs/3/实验3-1图_拼接.png
%   - outputs/3/实验3-1图_蓝色环.png

    if nargin < 2
        error('参数错误：需要传入两个参数');
    end

    disp("==== 图像处理1 ====")
    % 读取图像
    img = imread('exp3/实验3-1图.png');
    fprintf('读取输入图像: %s\n', 'exp3/实验3-1图.png');

    % 任务1：将图像旋转90度
    cw_rotated_img = rot90(img, -1);
    ccw_rotated_img = rot90(img);

    % 根据显示参数决定是否显示图像
    if show_images
        figure('Position', [100, 100, 1800, 600]);
        subplot(1, 3, 1);
        imshow(img);
        title('原图像');
        
        subplot(1, 3, 2);
        imshow(cw_rotated_img);
        title('顺时针旋转90度后的图像');
        
        subplot(1, 3, 3);
        imshow(ccw_rotated_img);
        title('逆时针旋转90度后的图像');
    end

    % 保存旋转后的图像
    if save_images
        imwrite(cw_rotated_img, 'outputs/3/实验3-1图_顺时针旋转90度.png');
        imwrite(ccw_rotated_img, 'outputs/3/实验3-1图_逆时针旋转90度.png');
        fprintf('保存旋转图像到: %s\n', 'outputs/3/实验3-1图_顺时针旋转90度.png');
        fprintf('保存旋转图像到: %s\n', 'outputs/3/实验3-1图_逆时针旋转90度.png');
    end

    % 任务2：将图像复制八份，按2×4布局拼接成一张图
    tiled_img = repmat(img, 2, 4);

    % 根据显示参数决定是否显示拼接图像
    if show_images
        figure;
        imshow(tiled_img);
        title('2×4布局拼接图像');
    end

    % 保存拼接后的图像
    if save_images
        imwrite(tiled_img, 'outputs/3/实验3-1图_拼接.png');
        fprintf('保存拼接图像到: %s\n', 'outputs/3/实验3-1图_拼接.png');
    end

    % 任务3：提取蓝色通道，非蓝色部分设为透明
    % 获取三个通道
    red_channel = img(:, :, 1);
    green_channel = img(:, :, 2);
    blue_channel = img(:, :, 3);

    % 定义阈值，蓝色通道需要比其他通道值高多少才被视为蓝色
    threshold = 20;

    % 创建蓝色掩码; 对矩阵的>运算返回逻辑矩阵；&运算符表示逻辑与
    blue_mask = (blue_channel > red_channel + threshold) & (blue_channel > green_channel + threshold);

    % 创建带白色背景的版本
    white_bg_img = ones(size(img), 'uint8') * 255;  % 创建白色背景
    % 在蓝色环区域，红色和绿色通道设为0
    white_bg_img(:,:,1) = white_bg_img(:,:,1) .* uint8(~blue_mask);
    white_bg_img(:,:,2) = white_bg_img(:,:,2) .* uint8(~blue_mask);
    % 添加蓝色环
    white_bg_img(:,:,3) = blue_channel .* uint8(blue_mask) + white_bg_img(:,:,3) .* uint8(~blue_mask);

    % 根据显示参数决定是否显示白底蓝色环图像
    if show_images
        figure;
        imshow(white_bg_img);
        title('白色背景的蓝色环');
    end

    % 保存带白色背景的蓝色环图像
    if save_images
        imwrite(white_bg_img, 'outputs/3/实验3-1图_蓝色环.png');
        fprintf('保存蓝色环图像到: %s\n', 'outputs/3/实验3-1图_蓝色环.png');
    end

    disp('图像处理1完成');
end

% ---------------------------------------------
function img_process2(show_images, save_images)
% IMG_PROCESS2 - 图像处理函数2
%
% 本函数实现以下图像处理功能：
%   1. 使用Canny算法提取图像边缘特征
%   2. 对图像进行锐化处理
%   3. 对图像进行模糊化处理
%
% 语法:
%   img_process2(show_images, save_images)
%
% 输入参数:
%   show_images - 逻辑值，控制是否显示处理结果
%   save_images - 逻辑值，控制是否保存处理结果到文件
%
% 输入文件:
%   - exp3/实验3-2图.png
%
% 输出文件:
%   - outputs/3/实验3-2图_边缘特征.png
%   - outputs/3/实验3-2图_锐化.png
%   - outputs/3/实验3-2图_模糊化.png

    if nargin < 2
        error('参数错误：需要传入两个参数');
    end

    disp('==== 图像处理2 ====');

    % 读取图像
    img = imread('exp3/实验3-2图.png');
    fprintf('读取输入图像: %s\n', 'exp3/实验3-2图.png');

    % ==== 任务1：提取边缘特征 ==== %
    edge_img = edge(rgb2gray(img), 'Canny'); % 使用Canny算法提取边缘

    % ==== 任务2：对图像进行锐化、模糊化处理 ==== %
    % 使用imsharpen函数锐化图像
    sharpened_img = imsharpen(img, 'Radius', 2, 'Amount', 1.5); 
    
    % 使用高斯滤波器进行模糊化
    blurred_img = imgaussfilt(img, 5);

    % ==== 显示图像和保存图像 ==== %
    if show_images
        % 显示原图和边缘特征
        figure('Position', [100, 100, 1000, 500]);
        subplot(1, 2, 1);
        imshow(img);
        title('原图像');
        
        subplot(1, 2, 2);
        imshow(edge_img);
        title('边缘特征');
        
        % 显示锐化和模糊处理结果
        figure('Position', [100, 100, 1500, 500]);
        subplot(1, 3, 1);
        imshow(img);
        title('原图像');
        
        subplot(1, 3, 2);
        imshow(sharpened_img);
        title('锐化后的图像');
        
        subplot(1, 3, 3);
        imshow(blurred_img);
        title('模糊化后的图像');
    end

    if save_images
        imwrite(edge_img, 'outputs/3/实验3-2图_边缘特征.png');
        imwrite(sharpened_img, 'outputs/3/实验3-2图_锐化.png');
        imwrite(blurred_img, 'outputs/3/实验3-2图_模糊化.png');
        fprintf('保存边缘特征图像到: %s\n', 'outputs/3/实验3-2图_边缘特征.png');
        fprintf('保存锐化图像到: %s\n', 'outputs/3/实验3-2图_锐化.png');
        fprintf('保存模糊化图像到: %s\n', 'outputs/3/实验3-2图_模糊化.png');
    end

    disp('图像处理2完成');
end

% ---------------------------------------------
function symbolic_math(show_results, save_results)
% SYMBOLIC_MATH - 符号运算函数
%
% 本函数实现以下符号运算功能：
%   1. 求极限 lim_{x -> 1}(x^2-1)/(x-1) 的值
%   2. 求函数 y = x^2-5sin(x)+ln(x) 的导数
%   3. 求不定积分 ∫(3x+sin(x))dx
%   4. 求定积分 ∫[0,3]x·sin(x)dx
%   5. 求(x+y)^5的展开式
%
% 语法:
%   symbolic_math(show_results, save_results)
%
% 输入参数:
%   show_results - 逻辑值，控制是否在控制台显示运算结果
%   save_results - 逻辑值，控制是否保存运算结果到文件
%
% 输出文件:
%   - outputs/3/exp3_符号运算结果.md

    if nargin < 2
        error('参数错误：需要传入两个参数');
    end
    
    if show_results
        fprintf('\n===== 符号运算 =====\n\n');
    end

    % 创建符号变量
    syms x y;

    % 1. 求lim_{x -> 1}(x^2-1)/(x-1)的值
    f1 = (x^2-1)/(x-1);
    limit_result = limit(f1, x, 1);
    if show_results
        fprintf('1. 求lim_{x -> 1}(x^2-1)/(x-1)的值 = %s\n\n', char(limit_result));
    end

    % 2. 求y = x^2-5sin(x)+ln(x)的导数
    f2 = x^2-5*sin(x)+log(x);
    deriv_result = diff(f2, x);
    if show_results
        fprintf('2. 求y = x^2-5sin(x)+ln(x)的导数 = %s\n\n', char(deriv_result));
    end

    % 3. 求∫(3x+sin(x))dx
    f3 = 3*x+sin(x);
    indef_integral = int(f3, x);
    if show_results
        % 不定积分的结果不含常数项，需要手动添加
        fprintf('3. 求∫(3x+sin(x))dx = %s + C\n\n', char(indef_integral));
    end

    % 4. 求∫[0,3]x·sin(x)dx
    f4 = x*sin(x);
    def_integral = int(f4, x, 0, 3);
    if show_results
        fprintf('4. 求∫[0,3]x·sin(x)dx = %s\n', char(def_integral));
        fprintf('   数值结果 ≈ %f\n\n', double(def_integral));
    end

    % 5. 求(x+y)^5的展开式
    f5 = (x+y)^5;
    expanded = expand(f5);
    if show_results
        fprintf('5. 求(x+y)^5的展开式 = %s\n\n', char(expanded));
    end

    % 保存运算结果到Markdown文件
    if save_results
        filename = 'outputs/3/exp3_符号运算结果.md';
        fileID = fopen(filename, 'w');

        % 写入结果到文件
        fprintf(fileID, '# 符号运算结果\n\n');

        fprintf(fileID, '- 1. 求$\\displaystyle\\lim_{x \\to 1}\\frac{x^{2}-1}{x - 1}$的值\n');
        fprintf(fileID, '  - 结果: $\\displaystyle %s$\n\n', latex(limit_result));

        fprintf(fileID, '- 2. 求$y = x^{2}-5\\sin x+\\ln x$的导数\n');
        fprintf(fileID, '  - 结果: $\\displaystyle %s$\n\n', latex(deriv_result));

        fprintf(fileID, '- 3. 求$\\displaystyle\\int \\left(3x+ \\sin x \\right)\\textrm{d}x$\n');
        fprintf(fileID, '  - 结果: $\\displaystyle %s + C$\n\n', latex(indef_integral));

        fprintf(fileID, '- 4. 求$\\displaystyle\\int\\limits_{0}^{3}\\left (x\\sin x \\right) \\textrm{d}x$\n');
        fprintf(fileID, '  - 结果: $\\displaystyle %s$\n', latex(def_integral));
        fprintf(fileID, '  - 数值近似: $\\approx %.6f$\n\n', double(def_integral));

        fprintf(fileID, '- 5. 求$(x + y)^{5}$的展开式\n');
        fprintf(fileID, '  - 结果: $\\displaystyle %s$\n\n', latex(expanded));

        % 关闭文件
        fclose(fileID);
        fprintf('符号运算结果已保存到文件: %s\n', filename);
    end

    disp('符号运算完成');
end
