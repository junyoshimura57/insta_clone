# 11 メール通知
## railsでのメール実装概要(現場RailsP,299~、パRailsP,235)
Action Mailerを仕組みを使って実装をする  
コントローラーのようにテンプレートを通じてメールを作成・送信をする。

### 実装手順
①ジェネレータを使用してメイラーを作成
```rb
bin/rails g mailer TaskMailer
```

②作成したメイラーにメソッドを追加する  
メイラークラスは、コントローラーと似ていて以下の機能がある。  
・ paramsオブジェクトを経由して渡されたデータを取得する  
・ メイラークラスで処理した内容をインスタンス変数へ代入してビューへ渡す  
・ コールバックやヘルパーメソッドが用意されている

例として以下のように記載をする。
```rb
class TaskMailer < ApplicationMailer
  def creation_email(task)
    # メールの送信元をデフォルト指定したい場合は、以下に記載をする。 
    # application_mailer.rbに記載をすると全てのメール送信元になる。  
    default from: 'taskleaf@example.com'
    # テンプレートとして利用するためにインスタンス変数に入れておく。
    @task = task 
    mail(
      subject: 'タスク作成完了メール', 
      to: 'user@example.com',
      from: 'taskleaf@example.com'
    ) 
  end
end
```

③テンプレートファイルを作成する  
特に指定しない場合は、以下がメイラーからテンプレートとして呼ばれる。  
■htmlメール
```  
/views/メイラーのクラス名(スネークケース)/アクション名.html.slim
```
■textメール
```  xx
/views/メイラーのクラス名(スネークケース)/アクション名.text.slim
```

④メール送信処理  
以下のように用意したメイラーをコントローラから呼び出しを行う。
```rb
# app/controllers/tasks_controller.rb
# すぐに送信をする場合
TaskMailer.creation_email(@task).deliver_now

# パrailsではwithメソッドでparamsを使って引数を渡していた。
```

## letter_operner_webとは？？
### 概要
開発環境で正しくメールが送信できているかを確認するgem（現場Railsでは、mailcatcherというgemを使っていた。パRailsではデフォルトの機能でメールをファイルとして保存する方法を使用していた。）

### 使用方法
①開発環境にgemファイルの導入

②routes.rbに以下を記載
```rb
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
```

③config/environments/development.rbに以下を記載。
```rb
  config.action_mailer.delivery_method = :letter_opener_web
```

④http://localhost:3000/letter_openerにアクセスができるようになる。

■参考  
[公式](https://github.com/fgrehm/letter_opener_web)

## configとは？？
### 概要
yaml形式で定数管理をするgem  
※[yamlの書き方について](https://tech.windii.jp/tool/yaml)

### 使用方法
①bundle exec rails g config:installで以下のファイルが生成される。  
[![Image from Gyazo](https://i.gyazo.com/2a6eee32073b505776033aca92e64112.png)](https://gyazo.com/2a6eee32073b505776033aca92e64112)

②ファイルに定数を記載することで、ControllerやViewなどで定数の呼び出しが可能となる。

■参考  
[【Rails】「config」gemを使って定数管理をおこなう方法](http://vdeep.net/rubyonrails-config-gem)
