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

% 图像处理1
img_process1();


% ---------------------------------------------
% 图像处理1函数
function img_process1()
    % 读取图像
    img = imread('exp3/实验3-1图.png');
    
    % 任务1：将图像旋转90度（逆时针）
    rotated_img = rot90(img);
    
    % 显示原图像和旋转后的图像
    figure;
    subplot(1, 2, 1);
    imshow(img);
    title('原图像');
    
    subplot(1, 2, 2);
    imshow(rotated_img);
    title('旋转90度后的图像');
    
    % 保存旋转后的图像
    imwrite(rotated_img, 'images/3/exp3-1_旋转90度.png');
    
    % 任务2：将图像复制八份，按2×4布局拼接成一张图
    tiled_img = repmat(img, 2, 4);
    
    % 显示拼接后的图像
    figure;
    imshow(tiled_img);
    title('2×4布局拼接图像');
    
    % 保存拼接后的图像
    imwrite(tiled_img, '实验3-1图_拼接.png');
    
    % 任务3：提取蓝色通道，非蓝色部分设为透明
    % 获取三个通道
    red_channel = img(:, :, 1);
    green_channel = img(:, :, 2);
    blue_channel = img(:, :, 3);
    
    % 定义阈值，蓝色通道需要比其他通道值高多少才被视为蓝色
    threshold = 30;
    
    % 创建蓝色掩码，只有当蓝色值明显高于红色和绿色时才保留
    blue_mask = (blue_channel > red_channel + threshold) & (blue_channel > green_channel + threshold);
    
    % 创建RGB图像
    blue_ring_img = zeros(size(img), 'uint8');
    blue_ring_img(:, :, 3) = blue_channel .* uint8(blue_mask);  % 只保留蓝色区域的蓝色通道
    
    % 创建Alpha通道 - 蓝色区域不透明，其他区域透明
    alpha_channel = uint8(blue_mask) * 255;  % 255表示完全不透明
    
    % 显示提取的蓝色环图像（显示时无法直接看到透明效果）
    figure;
    imshow(blue_ring_img);
    title('提取的蓝色环（保存后背景透明）');
    
    % 保存提取的蓝色环图像，使用Alpha通道实现透明效果
    imwrite(blue_ring_img, '实验3-1图_蓝色环.png', 'Alpha', alpha_channel);
end
