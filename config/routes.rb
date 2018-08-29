Rails.application.routes.draw do
  root 'users#new'
  resources :users
  get '/auth/:provider/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
