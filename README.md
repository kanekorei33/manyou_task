モデル名：user
| カラム名 | データ型 |
| ---- | ---- |
| name | string |
| email | string |
| email | index |
| password_digest | string |
| admin | boolean |

モデル名：task
| カラム名 | データ型 |
| ---- | ---- |
| title | string |
| title | index |
| content | string |
| deadline | datetime |
| status | integer |
| priority | integer |
| user_id | bigint |
| user_id | index |

モデル名：label
| カラム名 | データ型 |
| ---- | ---- |
| label | string |

モデル名：task_label
| カラム名 | データ型 |
| ---- | ---- |
| task_id | string |
| label_id | string |


##Heroku デプロイ手順

Heroku に新しいアプリケーションを作成する

```
$heroku create
```

Heroku buildpackを追加する
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
Herokuにデプロイをする
```
git push heroku `pushするブランチ名`:master
```
デプロイ完了後、データベースの移行を行う
```
$heroku run rails db:migrate
```
