Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/index'

  get 'home/welcome'

  get 'home/about'

  resources :labels
  resources :articles
  resource :settings
  resource :profile
  
end
