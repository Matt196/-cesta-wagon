Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :producers, only: [:index, :show, :new, :create] do
    resources :products, only:[:new, :create]
  end

  resources :products, only:[:index, :show, :edit, :update, :destroy]

  get '/guidelines', to: 'pages#guidelines'
  root to: 'pages#home'

end
