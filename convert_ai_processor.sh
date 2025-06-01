#!/bin/bash

# AIファイルをPNGに変換して背景を透過するプロセッサースクリプト
# convert_ai_directory.shから呼び出されます

# 設定ファイルの読み込み
CONFIG_FILE="$(dirname "$0")/config.sh"
if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ エラー: 設定ファイル '$CONFIG_FILE' が見つかりません"
  exit 1
fi
source "$CONFIG_FILE"

# 引数を取得
AI_FILE="$1"
OUTPUT_DIR="$2"
CURRENT="$3"
TOTAL="$4"

# ファイル名（拡張子なし）を取得
base_name=$(basename "$AI_FILE" .ai)
tmp_png="${OUTPUT_DIR}/${base_name}_tmp.png"
out_png="${OUTPUT_DIR}/${base_name}.png"

# 変換中のメッセージを表示
echo -e "\n🖼️ 変換中: $(basename "$AI_FILE")"

# ステップ1: AI → PNG（白背景にしてから削除）
magick "$AI_FILE" -density ${IMAGE_DENSITY} -background white -alpha remove -alpha off "$tmp_png"

# ステップ2: 白背景を透過
magick "$tmp_png" -fuzz ${FUZZ_FACTOR}% -transparent white "$out_png"

# 一時ファイル削除
rm "$tmp_png"

# カウンターを表示
percentage=$((CURRENT * 100 / TOTAL))
echo -ne "\r💯 進捗状況: $CURRENT / $TOTAL ファイル完了 ($percentage%) "