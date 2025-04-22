#!/bin/bash

# ===== Default variable values =====
SEQ_LENGTHS=(65536)
DATA_DIR="/data/yutao/ruler"
BENCHMARK="synthetic"
TOKENIZER_PATH="Qwen/Qwen2.5-7B"         # 请根据实际路径修改
TOKENIZER_TYPE="hf"                          # 例如 'hf' 或 'custom'
MODEL_TEMPLATE_TYPE="base"                # 例如 'default', 'chat', 'icl' 等
NUM_SAMPLES=100                              # 样本数量
REMOVE_NEWLINE_TAB=""                        # 如果需要添加如 --remove_newline_tab 则填 "--remove_newline_tab"

# ===== Task list =====
TASKS=("niah_single" "niah_multikey" "niah_multivalue" "niah_multiquery" "vt" "cwe" "fwe" "qa")

# ===== Create data directory =====
mkdir -p ${DATA_DIR}

# ===== Prepare data per task and seq length =====
for MAX_SEQ_LENGTH in "${SEQ_LENGTHS[@]}"; do
    for TASK in "${TASKS[@]}"; do
        python data/prepare.py \
            --save_dir ${DATA_DIR} \
            --benchmark ${BENCHMARK} \
            --task ${TASK} \
            --tokenizer_path ${TOKENIZER_PATH} \
            --tokenizer_type ${TOKENIZER_TYPE} \
            --max_seq_length ${MAX_SEQ_LENGTH} \
            --model_template_type ${MODEL_TEMPLATE_TYPE} \
            --num_samples ${NUM_SAMPLES} \
            ${REMOVE_NEWLINE_TAB}
    done
done