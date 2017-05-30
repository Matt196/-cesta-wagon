Rails.application.routes.draw do
  devise_for :users
   resources :producers, only: [:index, :show, :new, :create]

  get '/guidelines', to: 'pages#guidelines'
  root to: 'pages#home'

end
