Rails.application.routes.draw do
  get 'groups/new'

  get 'users/new'

  get 'messages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'messages#index'
end

