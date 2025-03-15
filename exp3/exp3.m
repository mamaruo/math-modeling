% 实验三：图像处理和符号运算
% 主函数 - 提供各部分实验的调用入口

% 清空工作区和关闭所有图像
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

% 图像处理2
img_process2(true);

% ---------------------------------------------
% 图像处理1函数
function img_process1(show_images)
    % 如果未传入显示参数，默认为false
    if nargin < 1
        show_images = false;
    end
    
    % 读取图像
    img = imread('exp3/实验3-1图.png');
    
    % 任务1：将图像旋转90度
    cw_rotated_img = rot90(img, -1);
    ccw_rotated_img = rot90(img);

    % 根据显示参数决定是否显示图像
    if show_images
        % 显示原图像和旋转后的图像
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
    imwrite(cw_rotated_img, 'images/3/实验3-1图_顺时针旋转90度.png');
    imwrite(ccw_rotated_img, 'images/3/实验3-1图_逆时针旋转90度.png');

    % 任务2：将图像复制八份，按2×4布局拼接成一张图
    tiled_img = repmat(img, 2, 4);
    
    % 根据显示参数决定是否显示拼接图像
    if show_images
        figure;
        imshow(tiled_img);
        title('2×4布局拼接图像');
    end
    
    % 保存拼接后的图像
    imwrite(tiled_img, 'images/3/实验3-1图_拼接.png');
    
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
    imwrite(white_bg_img, 'images/3/实验3-1图_蓝色环.png');
end

% ---------------------------------------------
% 图像处理2函数
function img_process2(show_images)
    % 如果未传入显示参数，默认为false
    if nargin < 1
        show_images = false;
    end
    
    % 读取图像
    img = imread('exp3/实验3-2图.png');
    
    % 任务1：提取边缘特征
    % 使用Canny算法提取边缘
    edge_img = edge(rgb2gray(img), 'Canny');
    
    % 任务2：对图像进行锐化处理
    % 使用imsharpen函数锐化图像
    sharpened_img = imsharpen(img, 'Radius', 2, 'Amount', 1.5);
    
    % 任务2：对图像进行模糊化处理
    % 使用高斯滤波器进行模糊化
    blurred_img = imgaussfilt(img, 3);
    
    % 根据显示参数决定是否显示处理后的图像
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
    
    % 保存处理后的图像
    imwrite(edge_img, 'images/3/实验3-2图_边缘特征.png');
    imwrite(sharpened_img, 'images/3/实验3-2图_锐化.png');
    imwrite(blurred_img, 'images/3/实验3-2图_模糊化.png');
end
