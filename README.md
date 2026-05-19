そのまま `README.md` に全貼りでOK。

````md
# AI-Soup

AIが「はい / いいえ / 関係ない」で回答する、ウミガメのスープ風のクイズWebアプリです。

ユーザーは問題に対して自由に質問を投稿でき、AIが出題者の代わりに回答します。

## 作成目的

Web開発職への転職を目的として、Ruby on Railsを使ったWebアプリ開発の基礎を学ぶために作成しました。

単なるCRUDアプリではなく、外部API連携、フォーム処理、バリデーション、DB設計、環境変数管理まで含めたアプリとして実装しています。

## 使用技術

### 現在使用している技術

- Ruby
- Ruby on Rails
- HTML
- CSS
- JavaScript
- SQLite
- OpenAI API
- Git / GitHub

### 今後導入予定の技術

- PostgreSQL
- AWS EC2
- Nginx
- Puma
- Amazon RDS for PostgreSQL

## 主な機能

- クイズ問題の投稿
- クイズ問題の一覧表示
- クイズ問題の詳細表示
- 問題に対する質問投稿
- AIによる「はい / いいえ / 関係ない」の自動回答
- 質問履歴の表示
- 空欄投稿・長文投稿のバリデーション
- 正解・解説の非表示化

## アプリの概要

出題者は、以下の情報を登録します。

- タイトル
- 問題文
- 正解
- 解説

プレイヤーには、問題文のみが表示されます。

プレイヤーが質問を投稿すると、OpenAI APIを利用してAIが回答を生成します。

AIの回答はそのまま表示せず、以下の3種類に正規化しています。

- はい
- いいえ
- 関係ない

これにより、ウミガメのスープのゲーム性を保つようにしています。

## DB設計

### SoupQuestion

クイズ問題を管理するモデルです。

| カラム | 内容 |
|---|---|
| title | 問題タイトル |
| body | 問題文 |
| answer | 正解 |
| explanation | 解説 |

### Question

プレイヤーから投稿された質問を管理するモデルです。

| カラム | 内容 |
|---|---|
| soup_question_id | 紐づく問題 |
| body | 質問内容 |
| answer | AIによる回答 |

## モデルの関連

```ruby
class SoupQuestion < ApplicationRecord
  has_many :questions, dependent: :destroy
end
```

```ruby
class Question < ApplicationRecord
  belongs_to :soup_question
end
```

1つの問題に対して、複数の質問が紐づく構造にしています。

## AI回答の流れ

1. ユーザーが質問を投稿する
2. RailsのControllerで質問内容を受け取る
3. 問題文・正解・質問内容をOpenAI APIへ送信する
4. AIから回答を取得する
5. 回答を「はい / いいえ / 関係ない」のいずれかに整形する
6. 質問履歴としてDBに保存する

## 工夫した点

### 1. AI回答の正規化

OpenAI APIの回答は、そのままだと表記が揺れる可能性があります。

例：

- はい。
- いいえです
- 関係ありません

そのため、回答を画面に表示する前に「はい / いいえ / 関係ない」の3種類に整形しています。

### 2. 正解の非表示化

ゲームとして成立させるため、プレイヤー画面では正解・解説を表示しないようにしました。

### 3. バリデーション

空欄の質問や長すぎる質問を投稿できないようにしています。

```ruby
validates :body, presence: true, length: { maximum: 200 }
```

### 4. APIキーの管理

OpenAI APIキーはコードに直接書かず、環境変数で管理しています。

```ruby
ENV.fetch("OPENAI_API_KEY")
```

APIキーをGitHubに公開しないように注意しています。

## 学んだこと

このアプリを通して、以下を学びました。

- RailsのMVC構造
- ルーティング
- Controllerでのリクエスト処理
- Modelの関連付け
- form_withによるフォーム作成
- paramsとStrong Parameters
- バリデーション
- 外部API連携
- 環境変数による秘密情報管理
- Git / GitHubでのバージョン管理

## 今後の改善予定

### 1. PostgreSQLへの移行

現在はSQLiteを使用していますが、本番環境を想定してPostgreSQLへ移行予定です。

### 2. AWSへのデプロイ

AWS上に本番環境を構築する予定です。

想定構成：

```text
ユーザー
↓
Nginx
↓
Puma
↓
Rails
↓
Amazon RDS for PostgreSQL
```

### 3. UI改善

HTML / CSS / JavaScriptを使い、より見やすく遊びやすい画面に改善予定です。

### 4. 管理者機能

今後は、問題作成者とプレイヤーを分けるために、管理者機能の追加を検討しています。

### 5. テスト追加

モデル・コントローラーのテストを追加し、機能の安定性を高める予定です。

## セットアップ

```bash
git clone https://github.com/Gengen0123/AI-Soup.git
cd AI-Soup
bundle install
bin/rails db:migrate
```

OpenAI APIキーを環境変数に設定します。

```bash
export OPENAI_API_KEY="your_api_key"
```

Railsサーバーを起動します。

```bash
bin/rails server
```

ブラウザで以下にアクセスします。

```text
http://localhost:3000
```

## 注意事項

OpenAI APIキーは外部に公開しないでください。

`.env` やAPIキーを含むファイルはGitHubにpushしないようにしています。
````
