Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :book do
    collection do
      post 'destroy_multiple'
    end
  end
  resources :rating, only: [:create]
  get '/rating', to: 'rating#create'
  root 'book#index'
end
