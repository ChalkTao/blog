Rails.application.routes.draw do

  devise_for :users

  root 'home#index'
  get 'labels/index'
  get 'labels/show'
  get 'articles/show'
  get 'home/index'
  get 'home/about'
  get 'search/:keyword', to: 'home#search'

  resources :labels, only: [:index, :show]
  resources :articles, only: [:index, :show]

  namespace :admin do
    root 'articles#index'
		resources :labels, except: [:edit]
  	resources :articles do 
      collection do
        post :preview
      end
    end
  end
  resource :settings
  resource :profile
  
end
