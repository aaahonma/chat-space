Rails.application.routes.draw do
  resources :users
  resources :groups do
    resources :messages
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'messages#index'
end
