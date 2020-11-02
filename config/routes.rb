Rails.application.routes.draw do
  root 'posts#index'

  # %iでシンボルの配列がリテラルでかける。
  resources :users, only: %i[new create]
  resources :posts

  # セッション管理のルーティングを以下に記載。
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
