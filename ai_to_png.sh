#!/bin/bash

# AIファイルをPNGに変換し、白背景を透過するスクリプト

# 入力ファイル名（拡張子なし）
INPUT_FILE="$1"
BASENAME=$(basename "$INPUT_FILE" .ai)
TMP_PNG="${BASENAME}_tmp.png"
OUTPUT_PNG="${BASENAME}.png"

# ステップ1: AI → PNGに変換（高解像度で）
magick "${BASENAME}.ai" -density 300 -background white -alpha remove -alpha off "$TMP_PNG"

# ステップ2: 白を透過させる
magick "$TMP_PNG" -fuzz 10% -transparent white "$OUTPUT_PNG"

# 一時ファイル削除
rm "$TMP_PNG"

echo "✔️ 変換完了: $OUTPUT_PNG"
