#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
分割大文件为多个小文件
"""
import os
import sys

def split_file(filename, chunk_size=95*1024*1024):
    """分割文件为多个部分"""
    if not os.path.exists(filename):
        print(f"错误: 文件 {filename} 不存在")
        return False

    file_size = os.path.getsize(filename)
    print(f"处理文件: {filename} ({file_size/1024/1024:.2f} MB)")

    part_num = 1
    with open(filename, 'rb') as f:
        while True:
            chunk = f.read(chunk_size)
            if not chunk:
                break

            part_name = f"{filename}.part{part_num}"
            with open(part_name, 'wb') as part_file:
                part_file.write(chunk)

            print(f"  创建: {part_name} ({len(chunk)/1024/1024:.2f} MB)")
            part_num += 1

    # 删除原文件
    os.remove(filename)
    print(f"  ✓ 已删除原文件 {filename}")
    print(f"  ✓ 共分为 {part_num-1} 卷")
    return True

if __name__ == "__main__":
    # 分割文件
    files_to_split = [
        "0-制作日志.zip",
        "3-模型训练.zip"
    ]

    for filename in files_to_split:
        split_file(filename)
        print()

    print("所有文件分割完成!")
