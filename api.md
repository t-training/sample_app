## API仕様書

### 実装されるAPI
- [Micropost閲覧API](#Micropost閲覧API)
- [フォローAPI](#フォローAPI)
- [ログインAPI](#ログインAPI)

### Micropost閲覧API
#### 概要
- クライアント側からリクエストがあったuser_idのmicropostsを返す

#### URI
- /api/v1/users/{user_id}/microposts

#### HTTPメソッド
- GET

#### 入力（リクエスト）
- user_id(Integer, required)
  - micropostsを表示するユーザーのID

#### 出力（レスポンス）
- 出力データ詳細
  - 200
    - 正常にレスポンスできた時
  - 404
    - 存在しないuser_idを指定した時

- micropostsが正常に返された時
  - user_name (String)：ユーザー名
  - icon_url (String)：アイコンのgravatarURL
  - microposts
    - id (Integer)：マイクロポストのid
    - content (String)：文章
    - user_id (Integer)：ユーザーID
    - created_at (Time:ISO 8601形式の日時文字列)：生成時間
    - updated_at (Time:ISO 8601形式の日時文字列)：更新時間
    - picture
      - url (String)：添付画像URL
      
- エラー時
  - status (Integer)：ステータスコード
  - error (String)：エラーメッセージ
    - 存在しないuser_idを指定したとき
      - Couldn't find User with 'id'=〜

#### JSONの例
- 正常時
  ```json
  {
    "user_name": "Example User",
    "icon_url": "https://secure.gravatar.com/avatar/bebfcf57d6d8277d806a9ef3385c078d?s=80",
    "microposts": [
      {
        "id": 295,
        "content": "Cumque eum quam sed neque dignissimos ut quaerat harum.",
        "user_id": 1,
        "created_at": "2020-05-11T09:13:55.107Z",
        "updated_at": "2020-05-11T09:13:55.107Z",
        "picture": {
          "url": null
        }
      },
      {
        "id": 289,
        "content": "Eius minus praesentium sunt dolorum.",
        "user_id": 1,
        "created_at": "2020-05-11T09:13:55.050Z",
        "updated_at": "2020-05-11T09:13:55.050Z",
        "picture": {
          "url": null
        }
      }
    ]
  }
  ```
- エラー時
  ```json
  {
    "status": 404,
    "error": "Couldn't find User with 'id'=10000"
  }
  ```

### フォローAPI
#### 概要
- クライアント側でフォローボタンが押された際にフォローする

#### URI
- /api/v1/users/{user_id}/relationships

#### HTTPメソッド
- POST

#### リクエストヘッダ

- Content-Type (required)
  - 常に `application/json` とする

- Authorization
  - type
    - `Token`
  - credentials
    - remember_tokenを記載
  - 例
    `Authorization: "Token HogehogeToken"`

#### 入力（リクエスト）
- user_id(Integer, required)
  - フォローする側のユーザーID
- followed_id(Integer, required)
  - フォローされる側のユーザーID
- token(token, required)
  - ログインページから持ってきて保存してあった認証トークン

#### 出力（レスポンス）
- 出力データ
  - ステータスコード
  - is_logged_in
    - ログインしているかどうか
  - followed
    - フォローできたかどうか

- 出力データ詳細
  - ステータス(String)
    - 200：正常にレスポンスできた時
    - 401：認証失敗した時
    - 404：リクエストしたリソースが存在しない時
  - is_logged_in(Boolean)
    - true：ログインしている
    - false：ログインしていない
  - followed(Boolean)
    - true：フォロー成功
    - false：フォロー失敗・すでにフォローしている

#### JSONの例
- 正常時
  - フォロー成功した時
    ```json
    {
      "status": "200",
      "is_logged_in": "true",
      "followed": "true",
    }
    ```
  - 既にフォローしている時
    ```json
    {
      "status": "200",
      "is_logged_in": "true",
      "followed": "false",
    }
    ```
- エラー時
  - user_idが存在しない・tokenが一致せずログインに失敗した時
    ```json
    {
      "status": "401",
      "is_logged_in": "false",
      "followed": "false",
    }
    ```
  - followed_idが存在しない時
    ```json
    {
      "status": "404",
      "is_logged_in": "true",
      "followed": "false",
    }
    ```
