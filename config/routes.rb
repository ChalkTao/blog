Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/index'

  get 'home/about'

  resources :labels, only: [:index]
  resources :articles, only: [:index, :show]

  namespace :admin do
    root 'articles#index'
		resources :labels, except: [:edit]
  	resources :articles
  end
  resource :settings
  resource :profile
  
end
