Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'

  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]

    # api::messages_controllerを追加
    # namespace :ディレクトリ名 do 〜 end
    # defaults: {format: 'json' }= defaultsオプションの指定。ルーティングが呼ばれたらjson形式でレスポンスする仕組み
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
