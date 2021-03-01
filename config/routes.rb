require 'sidekiq/web'

Rails.application.routes.draw do
  # development環境の際にletter_operner_webを使用できるように追加
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # mount Sidekiq::Web => '/sidekiq'と書くのと同じ様子
  mount Sidekiq::Web, at: '/sidekiq'
  root 'posts#index'

  # セッション管理のルーティングを以下に記載。
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # %iでシンボルの配列がリテラルでかける。
  resources :users, only: %i[new create show index]
  # shallowオプションでcommentsのedit,show,destroy,updateに/posts/:post_idが付かなくなる。
  resources :posts, shallow: true do
    resources :comments
    # /posts/searchのルーティングを作成する。(/posts/:id/searchとしたい場合は、memberを使う)
    get :search, on: :collection
  end
  # 今回はネストさせずにルーティングを設定(postsにネストさせてもできそう！)
  resources :likes, only: %i[create destroy]

  resources :relationships, only: %i[create destroy]

  # patchメソッドの「/activities/:id/read」のエンドポイントを作成する。
  resources :activities, only: [] do
    patch :read, on: :member
  end
  # 「マイページ系」の機能拡張を想定してnamespaceを使用する。(URL、ファイル構成ともにmypage配下になる)
  namespace :mypage do
    # アカウントはログインユーザーからみてアプリケーション上、１つしか存在しないので:idを生成しない「resource」を使用する。
    resource :account, only: %i[edit update]
    resources :activities, only: %i[index]
  end
end
