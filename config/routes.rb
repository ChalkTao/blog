Rails.application.routes.draw do

  devise_for :users

  root 'home#index'
  get 'labels/index'
  get 'labels/show'
  get 'articles/show'
  get 'home/index'
  get 'home/about'
  get 'search', to: 'home#search', as: :search
  get 'artcles', to: 'home#articles', as: :articles
  get 'artcle/:id', to: 'home#article', as: :article
  get 'categories', to: 'home#categories', as: :categories
  get 'category/:id', to: 'home#category', as: :category
  get 'label/:id', to: 'home#label', as: :label

  namespace :admin do
    root 'articles#index'
		resources :labels, except: [:edit]
    resources :categories, except: [:edit]

  	resources :articles do 
      collection do
        post :preview
        get :search
        get :draft
      end
    end
  end
  resource :settings
  resource :profile
  
end
