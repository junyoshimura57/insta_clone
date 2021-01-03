# 07 検索機能を実装
## 実装方針
ransackなどのgemを使用せず、フォームオブジェクト、ActiveModelを使用して実装する。  
(ransackを使用するパターンは現場Railsに記載あり。パRailsではsearchkickというgemを使用していた。)

### フォームオブジェクトとは？？(現場RailsのP,426、パRailのP,484、[メドピア開発者ブログ](https://tech.medpeer.co.jp/entry/2017/05/09/070758))
form_withのmodelオプションにActive Record以外のオブジェクトを渡すデザインパターンのこと。利点としては以下の2点がある。  
①DBを使わないフォームでも、Active Recordを利用した場合と同じ方法を利用できるので可読性が増す。  
②他の箇所に分散されがちなロジックをform object内に集めることができる。

### ActiveModelとは？？(現場RailsのP,427、パRailのP,477)
DBに直接紐付かないけれども、フォームの入力を検証して何らかの操作を行うモデルを作ることできる。  
ActiveModelを利用することで、自分で定義した素のRubyクラス(ActiveRecord::Baseを継承していない)にもActiveRecordの機能を使用できることができる。

【ActiveModelのモジュール】  
■ActiveModel::Attributes  
型を持つ属性の定義することができるモジュール
参考:[Quita](https://qiita.com/alpaca_taichou/items/bebace92f06af3f32898)  
以下のように定義ができる。
```ruby
class Person
include ActiveModel::Attributes
attribute :name, :string
attribute :age, :integer 
end
```

■ActiveModel::Model  
ActiveModel が提供するモジュール群の一部をまとめたモジュール  
以下の機能が使用できるようになる。参考:[Railsガイド](https://railsguides.jp/active_model_basics.html)  
・モデル名の調査  
・変換  
・翻訳  
・バリデーション  
・Action Viewヘルパーメソッド(form_withやrender)との連携  
