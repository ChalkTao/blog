Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/index'

  get 'home/welcome'

  get 'home/about'

  resources :labels, except: [:edit]
  resources :articles
  resource :settings
  resource :profile
  
end
