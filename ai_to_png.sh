#!/bin/bash

# AIファイルをPNGに変換し、白背景を透過するスクリプト

# 設定ファイルの読み込み
CONFIG_FILE="$(dirname "$0")/config.sh"
if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ エラー: 設定ファイル '$CONFIG_FILE' が見つかりません"
  exit 1
fi
source "$CONFIG_FILE"

# 入力ファイル名（拡張子なし）
INPUT_FILE="$1"
BASENAME=$(basename "$INPUT_FILE" .ai)
TMP_PNG="${BASENAME}_tmp.png"
OUTPUT_PNG="${BASENAME}.png"

# ステップ1: AI → PNGに変換（高解像度で）
magick "${BASENAME}.ai" -density ${IMAGE_DENSITY} -background white -alpha remove -alpha off "$TMP_PNG"

# ステップ2: 白を透過させる
magick "$TMP_PNG" -fuzz ${FUZZ_FACTOR}% -transparent white "$OUTPUT_PNG"

# 一時ファイル削除
rm "$TMP_PNG"

echo "✔️ 変換完了: $OUTPUT_PNG"
