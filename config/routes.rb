Rails.application.routes.draw do
  root 'posts#index'

  # %iでシンボルの配列がリテラルでかける。
  resources :users, only: %i[new create]
  # shallowオプションでcommentsのedit,show,destroy,updateに/posts/:post_idが付かなくなる。
  resources :posts, shallow: true do
    resources :comments
  end

  # セッション管理のルーティングを以下に記載。
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
