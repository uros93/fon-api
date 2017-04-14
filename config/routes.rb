Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'
  

  resources :users, only: [:show, :index]
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#profile'
  put 'profile/update', to: 'users#update'

  
  resources :websites do
  	resources :rss_links
  end
  resources :categories do
  end
end
