# .aiファイル変換ツール

このツールは、Adobe Illustrator（.ai）ファイルをPNG形式に変換し、背景を透過させるためのスクリプト集です。Slackにカスタム絵文字を追加する際に使いました。

## 機能

- AIファイルをPNG形式に変換
- 白背景を自動的に透過処理
- 単一ファイルの変換と、ディレクトリ単位での一括変換に対応
- 進捗状況をリアルタイム表示

## 必要条件

- macOS または Linux
- [ImageMagick](https://imagemagick.org/) v7以上

## インストール

同梱の`install.sh`スクリプトを実行することで、必要な依存関係をインストールできます。

```bash
# 実行権限を付与
chmod +x install.sh

# インストールを実行
./install.sh
```

## 使用方法

### 単一ファイルの変換

単一のAIファイルをPNGに変換するには、`ai_to_png.sh`スクリプトを使用します。

```bash
./ai_to_png.sh <ファイル名（拡張子なし）>
```

例：
```bash
./ai_to_png.sh 0001
```

これにより、`0001.ai`ファイルが`0001.png`に変換されます。

### ディレクトリ単位での一括変換

ディレクトリ内のすべてのAIファイルを一括変換するには、`convert_ai_directory.sh`スクリプトを使用します。

```bash
./convert_ai_directory.sh <入力ディレクトリ> [出力ディレクトリ]
```

例：
```bash
# デフォルトの出力先（入力ディレクトリ名_converted）を使用する場合
./convert_ai_directory.sh ./pictograph_data

# 出力先を指定する場合
./convert_ai_directory.sh ./pictograph_data ./output_png
```

- 出力ディレクトリが指定されない場合、デフォルトで「入力ディレクトリ名_converted」というディレクトリに出力されます
- 出力ディレクトリは自動的に作成されます

## 設定カスタマイズ

変換パラメータをカスタマイズする場合は、`config.sh`ファイルを編集してください。

```bash
# 変換解像度（DPI）
export IMAGE_DENSITY=300

# 透過処理時のfuzz値（%）- 大きくすると透過範囲が広がります
export FUZZ_FACTOR=50
```

## ファイル構成

- `ai_to_png.sh` - 単一ファイル変換スクリプト
- `convert_ai_directory.sh` - ディレクトリ一括変換スクリプト
- `convert_ai_processor.sh` - ファイル処理用サブスクリプト
- `config.sh` - 環境変数設定ファイル
- `install.sh` - 依存関係インストールスクリプト

## トラブルシューティング

### 実行権限エラー

スクリプトが実行できない場合は、実行権限を付与してください。

```bash
chmod +x *.sh
```

### 変換エラー

ファイルが変換できない場合は、以下を確認してください。

1. AIファイルが正しいフォーマットであること
2. ImageMagickが正しくインストールされていること（`magick --version`で確認）
3. 十分なディスク容量があること
