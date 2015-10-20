Rails.application.routes.draw do

  devise_for :users

  root 'home#index'
  get 'labels/index'
  get 'labels/show'
  get 'articles/show'
  get 'home/index'
  get 'home/about'
  get 'search/:keyword', to: 'home#search', as: :search
  get 'artcle/:id', to: 'home#article', as: :article
  get 'category', to: 'home#category', as: :category
  get 'label/:id', to: 'home#label', as: :label

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
