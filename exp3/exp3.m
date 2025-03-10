% 实验三：图像处理和符号运算
% 主函数 - 提供各部分实验的调用入口

% 清空工作区和关闭所有图像
clear;
close all;
clc;

% 图像处理1
img_process1();


% ---------------------------------------------
% 图像处理1函数
function img_process1()
    % 读取图像
    img = imread('实验3-1图.png');
    
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
    
    % 任务3：提取蓝色通道
    blue_channel = img(:, :, 3);
    
    % 创建一个只包含蓝色通道的图像
    blue_ring_img = zeros(size(img), 'uint8');
    blue_ring_img(:, :, 3) = blue_channel;
    
    % 显示提取的蓝色环图像
    figure;
    imshow(blue_ring_img);
    title('提取的蓝色环');
    
    % 保存提取的蓝色环图像
    imwrite(blue_ring_img, '实验3-1图_蓝色环.png');
end
