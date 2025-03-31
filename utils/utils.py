import os
import json

def change_working_directory():
    """
    读取配置文件并切换工作目录
    """
    try:
        # 获取当前脚本所在的目录路径
        current_dir = os.path.dirname(os.path.abspath(__file__))
        # 向上一层目录获取根目录
        root_dir = os.path.dirname(current_dir)
        # 构建配置文件的完整路径
        config_path = os.path.join(root_dir, 'config.json')
        
        # 读取JSON配置文件
        with open(config_path, 'r', encoding='utf-8') as config_file:
            config = json.load(config_file)
        
        # 获取工作目录
        work_dir = config['work_dir']
        
        # 切换到指定的工作目录
        os.chdir(work_dir)
        print(f'已切换到工作目录: {work_dir}')
    except Exception as e:
        print(f'读取配置文件出错: {e}')