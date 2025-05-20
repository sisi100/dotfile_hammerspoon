# Hammerspoon Configuration

macOSのキーボードとマウス操作をカスタマイズするためのHammerspoon設定ファイルです。

## 機能

### キーボードショートカット

- `⌘M`: テスト用アラート表示
- `⌃J`: Escapeキーを押して英数入力に切り替え
- `⌃P`: 上矢印キー
- `⌃N`: 下矢印キー
- `右Option`（ダブルタップ）: Launchpadを起動
- `右Command`（ダブルタップ）: Terminalを起動

### マウス機能

- 右クリックのカスタマイズ
  - 右クリックボタンを押したときに"down"アラートを表示
  - 右クリックボタンを離したときに"up"アラートを表示
- 右クリックドラッグでスクロール
  - 右クリックボタンを押しながらドラッグすることで画面をスクロール
  - スクロール速度は`scrollmult`変数で調整可能（デフォルト: -4）

## セットアップ

### 前提条件

- macOS
- [Homebrew](https://brew.sh/)

### インストール手順

1. Hammerspoonのインストール
```bash
brew install --cask hammerspoon
```

2. このリポジトリのクローン
```bash
git clone https://github.com/yourusername/dotfile_hammerspoon.git ~/.hammerspoon
```

3. セットアップスクリプトの実行
```bash
cd ~/.hammerspoon
./setup.sh
```

4. Hammerspoonの起動
   - Spotlight（⌘Space）で"Hammerspoon"を検索して起動
   - メニューバーのHammerspoonアイコンをクリックして"Reload Config"を選択

## プロジェクト構成

```
.
├── init.lua          # エントリーポイント
├── core/            # コア機能
│   ├── actions.lua  # アクション定義
│   ├── key_set.lua  # キーセットエンティティ
│   └── modifier_key.lua  # 修飾キーエンティティ
├── bindings/        # 入力デバイスのバインディング
│   ├── key.lua      # キーボード設定
│   └── mouse.lua    # マウス設定
├── README.md        # このファイル
└── setup.sh         # セットアップスクリプト
```

## カスタマイズ

### キーボードショートカットの追加

1. `core/actions.lua`に新しいアクションを追加
2. `bindings/key.lua`にキーバインドを追加

### マウス設定の変更

`bindings/mouse.lua`の以下の変数を編集：

- `scrollmult`: スクロール速度（デフォルト: -4）
- アラート表示の有効/無効

## トラブルシューティング

### 設定が反映されない場合

1. Hammerspoonが起動しているか確認
2. メニューバーのHammerspoonアイコンをクリックして"Reload Config"を選択
3. コンソールアプリでログを確認（`~/Library/Logs/DiagnosticReports/`）

### キーボードショートカットが機能しない場合

1. システム環境設定 > キーボード > ショートカットで競合がないか確認
2. 他のアプリケーションのショートカットと競合していないか確認

## ライセンス

MIT License

## 作者

[Your Name]
