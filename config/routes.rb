Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root 'posts#index'

  # %iでシンボルの配列がリテラルでかける。
  resources :users, only: %i[new create show index]
  # shallowオプションでcommentsのedit,show,destroy,updateに/posts/:post_idが付かなくなる。
  resources :posts, shallow: true do
    resources :comments
  end
  # 今回はネストさせずにルーティングを設定(postsにネストさせてもできそう！)
  resources :likes, only: %i[create destroy]

  resources :relationships, only: %i[create destroy]

  # セッション管理のルーティングを以下に記載。
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
