Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'
  

  resources :users, only: [:show, :index]
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#profile'
  put 'profile/update', to: 'users#update'

  get 'articles', to: 'articles#index'

  
  resources :websites do
  	resources :rss_links
    member do
      get 'articles'
    end
  end
  resources :categories do
    member do
      get 'articles'
    end
  end
end
