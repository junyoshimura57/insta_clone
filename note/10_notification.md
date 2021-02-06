# 10 通知機能の実装
## ポリモーフィック関連付けについて
■使用する場面  
1つのモデルが他の複数のモデルに属している場合  
例:活動状況モデルが「いいねモデル・コメントモデル・関係モデル」に属している場合

■テーブル設計  
「対象テーブル名・対象レコードID」を保管するカラムを作る。

■ER図  
[![Image from Gyazo](https://i.gyazo.com/28d73bcdce3bb42f0aa6b2337ea2ffb8.png)](https://gyazo.com/28d73bcdce3bb42f0aa6b2337ea2ffb8)

■ポリモーフィック関連付けの使いどころ  
一つのモデルを同じインターフェースを持ったものが扱う場合  
(新しく関連付けしたいモデルを作る時に外部キーを追加する必要がない)

■ポリモーフィック関連付け注意点  
①外部キーの設定ができないため、紐づくテーブルの保証ができない。（参照先に絶対レコードがあるという保証）  
②idが示す先のテーブルがレコードによって変化してしまう。  
[(参考)複数のテーブルに対して多対一で紐づくテーブルの設計アプローチ](https://spice-factory.co.jp/development/has-and-belongs-to-many-table/)


■参考  
[【Quita】Railsのポリモーフィック関連とはなんなのか
](https://qiita.com/itkrt2y/items/32ad1512fce1bf90c20b)  
[RailsのモデルのSTI(Single Table Inheritance)とポリモーフィックの実装](https://jq-jo.github.io/blog/2017/01/18/rails-model-polymorphic/)
