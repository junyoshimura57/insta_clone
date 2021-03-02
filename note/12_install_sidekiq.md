# 12 メールのジョブの永続化を実装
## そもそもメールのジョブの永続化とは？？(パRailsのP,240)
Action Mailerのdeliver_laterメソッドは非同期送信をする時に内部でActive Job(非同期実行処理機能を提供するライブラリー)を使っている。  
Active Jobの初期設定(asyncアダプター)では、Railsを再起動するとジョブが破棄されてしまう。  
そのためにActive Jobのキューを永続化させる必要がある。

## 永続化の方法
■概要  
Sidekiq、Resque、Delayed Jobなどを使って永続化をする。  
(キューを貯めるNoSQLとしてRedisなどを使用する)

■Sidekiqの場合のイメージ（間違えているかも...）  
①メールjobのhttpリクエストをクライアントからRailsサーバーに依頼。  
②Railsサーバーはメール処理については、Active Jobを経由してSidekiq&Redisにメール処理を依頼する。  
③メール処理に関しては非同期でSidekiq&Redisが実行をする。

## Sidekiqでの実装手順(現場RailsのP325)
※パRailsではdockerを使っていたため参考にならず...  
①gemを入れる。  
②config/application.rbにアダプターの設定をする。
```
module ActiveJobExample
  class Application < Rails::Application
    略
  config.active_job.queue_adapter = :sidekiq
end
```
③`bundle exec sidekiq`でsidekiqを起動する。

## ダッシュボードを利用する方法
■概要  
Sidekiqの現在の状態の管理画面を表示できるWebアプリケーション

■実装方法  
①shinatraのgemを入れる。

②routes.rbにダッシュボードのルーティングを設定する。
```rb
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
```

③http://localhost:3000/sidekiq/で管理画面をみれる。

■備考  
パRailsのP,220にはSidekiq のAPIを直接使う方法もあると書いてあった。  
Active Jobでは使えない機能が使えるようになるらしいが、Active JobをするAction Mailerなどは使えないらしい...
