#!/bin/bash

# 使用法: ./convert_ai_directory.sh /path/to/directory [出力先ディレクトリ]
# AIファイルをPNGに変換し、背景を透過させるスクリプト

# 設定ファイルの読み込み
CONFIG_FILE="$(dirname "$0")/config.sh"
if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ エラー: 設定ファイル '$CONFIG_FILE' が見つかりません"
  exit 1
fi
source "$CONFIG_FILE"

# 引数のチェック
if [ $# -lt 1 ]; then
  echo "❌ 使用法: $0 <入力ディレクトリ> [出力ディレクトリ]"
  echo "   デフォルト入力ディレクトリ: $DEFAULT_INPUT_DIR"
  exit 1
fi

# 入力ディレクトリのチェック
INPUT_DIR="$1"
if [ ! -d "$INPUT_DIR" ]; then
  echo "❌ エラー: 入力ディレクトリ '$INPUT_DIR' が存在しません"
  exit 1
fi

# 絶対パスを取得
INPUT_DIR=$(cd "$INPUT_DIR"; pwd)
PARENT_DIR=$(dirname "$INPUT_DIR")
DIR_NAME=$(basename "$INPUT_DIR")

# 出力ディレクトリの設定
if [ -n "$2" ]; then
  # 指定された出力ディレクトリを使用
  OUTPUT_DIR="$2"
  # 相対パスの場合は絶対パスに変換
  if [[ "$OUTPUT_DIR" != /* ]]; then
    OUTPUT_DIR="$(pwd)/$OUTPUT_DIR"
  fi
else
  # デフォルトの出力ディレクトリ
  OUTPUT_DIR="${PARENT_DIR}/${DIR_NAME}_converted"
fi

# 出力ディレクトリの作成
mkdir -p "$OUTPUT_DIR"

echo "🔄 変換開始: $INPUT_DIR → $OUTPUT_DIR"

# 処理するファイルの総数を取得
TOTAL_FILES=$(find "$INPUT_DIR" -type f -name '*.ai' | wc -l)
TOTAL_FILES=$(echo $TOTAL_FILES | tr -d ' ')
echo "📊 合計処理ファイル数: $TOTAL_FILES"

# プロセッサースクリプトの実行権限を確認
PROCESSOR_SCRIPT="$(dirname "$0")/convert_ai_processor.sh"
if [ ! -x "$PROCESSOR_SCRIPT" ]; then
  chmod +x "$PROCESSOR_SCRIPT"
fi

# 処理済みファイル数のカウンター
PROCESSED=0

# 処理開始前に初期状態を表示
echo -ne "\r💯 進捗状況: $PROCESSED / $TOTAL_FILES ファイル完了 (0%) "

# AIファイルをすべて変換
find "$INPUT_DIR" -type f -name '*.ai' | while read ai_file; do
  # カウンターを増やす
  PROCESSED=$((PROCESSED + 1))
  
  # プロセッサースクリプトを呼び出し
  "$PROCESSOR_SCRIPT" "$ai_file" "$OUTPUT_DIR" $PROCESSED $TOTAL_FILES
done

# 最後に改行を追加して完了メッセージを表示
echo -e "\n✅ すべてのAIファイルを変換しました: $OUTPUT_DIR"

