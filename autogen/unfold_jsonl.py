#!/usr/bin/env python3
import json
import os
import re

def extract_litex_code(proof_text):
    """从proof文本中提取最后一个```litex代码块"""
    # 使用正则表达式匹配```litex代码块
    pattern = r'```litex\s*\n(.*?)\n```'
    matches = re.findall(pattern, proof_text, re.DOTALL)
    
    if matches:
        # 返回最后一个匹配的代码块
        return matches[-1].strip()
    else:
        # 如果没有找到```litex代码块，尝试查找其他代码块
        pattern = r'```\s*\n(.*?)\n```'
        matches = re.findall(pattern, proof_text, re.DOTALL)
        if matches:
            return matches[-1].strip()
        else:
            return None

def process_jsonl_file(input_file, output_dir):
    """处理JSONL文件并创建.lix文件"""
    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)
    
    processed_count = 0
    skipped_count = 0
    
    with open(input_file, 'r', encoding='utf-8') as f:
        for line_num, line in enumerate(f, 1):
            line = line.strip()
            if not line:
                continue
                
            try:
                # 解析JSON
                data = json.loads(line)
                
                # 提取字段
                name = data.get('name', '')
                description = data.get('description', '')
                proof = data.get('proof', '')
                
                if not name:
                    print(f"警告: 第{line_num}行缺少name字段，跳过")
                    skipped_count += 1
                    continue
                
                # 提取litex代码
                litex_code = extract_litex_code(proof)
                
                if not litex_code:
                    print(f"警告: 第{line_num}行无法提取litex代码，跳过: {name}")
                    skipped_count += 1
                    continue
                
                # 创建.lix文件
                filename = f"{name}.lix"
                filepath = os.path.join(output_dir, filename)
                
                with open(filepath, 'w', encoding='utf-8') as lix_file:
                    # 写入描述作为注释
                    if description:
                        lix_file.write(f"# {description}\n\n")
                    
                    # 写入litex代码
                    lix_file.write(litex_code)
                    lix_file.write('\n')
                
                print(f"已创建: {filename}")
                processed_count += 1
                
            except json.JSONDecodeError as e:
                print(f"错误: 第{line_num}行JSON解析失败: {e}")
                skipped_count += 1
            except Exception as e:
                print(f"错误: 处理第{line_num}行时发生异常: {e}")
                skipped_count += 1
    
    print(f"\n处理完成!")
    print(f"成功处理: {processed_count} 个文件")
    print(f"跳过: {skipped_count} 个文件")

if __name__ == "__main__":
    input_file = "autogen/proof.jsonl"
    output_dir = "proof"
    
    if not os.path.exists(input_file):
        print(f"错误: 输入文件不存在: {input_file}")
        exit(1)
    
    process_jsonl_file(input_file, output_dir)
