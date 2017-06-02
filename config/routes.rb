Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :producers, only: [:index, :show, :new, :create, :edit, :update, :create, :destroy] do
    resources :products, only:[:new, :create]
    resources :producer_reviews, only:[:new, :create]

  end

  resource :basket_lines, only: [:show, :create]

  resources :products, only:[:index, :show, :edit, :update, :destroy]

  resources :producer_reviews, only:[:index, :show, :edit, :update, :destroy]

  resource :profile, only: :show

  get '/guidelines', to: 'pages#guidelines'
  root to: 'pages#home'

end
