#!/bin/bash

# 環境変数設定ファイル
# 他のスクリプトからsource commandで読み込まれます

# 基本ディレクトリパス
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 変換関連の設定
export IMAGE_DENSITY=300
export FUZZ_FACTOR=50  # 透過処理時のfuzz値（%）

# プロセッサースクリプトのパス
export PROCESSOR_SCRIPT="${SCRIPT_DIR}/convert_ai_processor.sh"