# ER図構成
#### Users
| Columns | Description |
| --- | --- |
| name | string |
|email|string|
|password_digest|string|
|image|string|
|section|string|

#### tasks
| Columns | Description |
| --- | --- |
|user_id|bigint|
|priority|integer|
|name|string|
|deadline|date|

#### groups
| Columns | Description |
| --- | --- |
|task_id|bigint|
|label_id|bigint|

#### statuses
| Columns | Description |
| --- | --- |
|task_id|bigint|
|name|string|

#### labels
| Columns | Description |
| --- | --- |
|name|string|



# heroku デプロイ手順
1. herokuへログイン
   - heroku login -i
2. herokuにアプリを作成
    - heroku create 
3. ローカルブランチstep2 をherokuにプッシュする
    - git push heroku step2:master
4. herokuにアプリ用のテーブルを作成
      - heroku run rails db:migrate