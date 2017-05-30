Rails.application.routes.draw do
  devise_for :users
   resources :producers, only: [:index, :show, :new, :create]

  root to: 'pages#home'

end
