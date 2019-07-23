Rails.application.routes.draw do
  resources :tokens, only: [:create]
  resources :users
  get '/testing', to: 'tokens#testing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
