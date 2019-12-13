Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books do
    collection do
      post 'destroy_multiple'
      post 'take'
      post 'return'
    end
  end
  resources :rating, only: [:create]
  resources :comments, except: %i[index new edit show]
  #get '/rating', to: 'rating#create'
  root 'books#index'
end
