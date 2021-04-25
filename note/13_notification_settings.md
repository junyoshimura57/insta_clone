# 13 通知の設定を実装
## 実施手順
1.DBにカラム追加をする。  
boolean型で3種類(いいね、コメント、フォロー)に対する通知フラグを作る。

2.エンドポイントは以下とする。  
| 1 | 通知編集画面を表示 | GET       | /mypage/notification_setting/edit | mypage/notification_settings#edit   |
| - | ------------------ | --------- | --------------------------------- | ----------------------------------- |
| 2 | 通知設定を更新     | PATCH/PUT | /mypage/notification_setting      | mypage/notification_settings#update |

3.ルーティングを追加する。  
通知設定の内容は、動的に増えたり、減ったりしないので、indexアクション不要&editアクションでidはいらないので、resouceで定義をする。  
※resouceの場合でもコントローラは複数形となる。(以下Railsガイド抜粋)  
[![Image from Gyazo](https://i.gyazo.com/c76b9c21d1067f1dc9c506f4e5496f44.png)](https://gyazo.com/c76b9c21d1067f1dc9c506f4e5496f44)

4.4.ビュー、コントローラーを作る。  
f.check_boxを使用してチェックボックスを作る。

5.メイラーの設定を変更する。  
(UserMailerクラスのメソッドを呼び出している箇所を修正する。)
