Rails.application.routes.draw do
  root 'users#new'

  # %iでシンボルの配列がリテラルでかける。
  resources :users, only: %i[new create]
  # セッション管理のルーティングを以下に記載。
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
