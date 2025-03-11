"""
验证哈希值。

通过命令行参数传入原始文本进行哈希验证
"""

import sys
from hashlib import blake2b

def generate_short_hash(data: str, digest_size: int = 4) -> str:
    raw_data = data.encode('utf-8')
    return blake2b(raw_data, digest_size=digest_size).hexdigest()

def verify_short_hash(data: str, expected_hash: str, digest_size: int = 4) -> bool:
    return generate_short_hash(data, digest_size) == expected_hash

if __name__ == "__main__":
    short_hash = "905362a7"
    
    if len(sys.argv) > 1:
        # 从命令行参数获取原始文本
        raw_data = sys.argv[1]
    else:
        # 如果没有提供命令行参数，提示用户输入
        raw_data = input("请输入需要验证的原始文本: ")
    
    # 验证哈希值
    is_valid = verify_short_hash(raw_data, short_hash)
    if is_valid:
        print("Hash有效")
    else:
        print("Hash无效")
