Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :users, except: [:create]
  resources :websites do
  	resources :rss_links
  end
  resources :categories do
  end
end
