#!/bin/bash

# ImageMagickインストールスクリプト
# AIファイル変換ツールのための依存関係をインストールします

echo "🔍 システムの確認中..."

# Homebrewがインストールされているか確認
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrewがインストールされていません"
    echo "🔄 Homebrewをインストールします..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ Homebrewのインストール完了"
else
    echo "✅ Homebrewは既にインストールされています"
fi

# ImageMagickがインストールされているか確認
if ! command -v magick &> /dev/null; then
    echo "❌ ImageMagickがインストールされていません"
    echo "🔄 ImageMagickをインストールします..."
    brew install imagemagick
    echo "✅ ImageMagickのインストール完了"
else
    echo "✅ ImageMagickは既にインストールされています"
    # 最新バージョンにアップデート
    echo "🔄 ImageMagickを最新バージョンに更新します..."
    brew upgrade imagemagick
    echo "✅ ImageMagickの更新完了"
fi

echo "📋 インストール情報："
echo "------------------------"
echo "Homebrew バージョン:"
brew --version
echo "------------------------"
echo "ImageMagick バージョン:"
magick --version | head -n 1
echo "------------------------"

echo "🎉 セットアップ完了！"
echo "📝 使用方法:"
echo "  - 単一ファイル変換: ./ai_to_png.sh [ファイル名(拡張子なし)]"
echo "  - ディレクトリ一括変換: ./convert_ai_directory.sh [ディレクトリパス]"
echo ""
echo "例: ./convert_ai_directory.sh ./pictograph_data"