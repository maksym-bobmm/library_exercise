# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :books do
    collection do
      post 'destroy_multiple'
      post 'take'
      post 'return'
    end
  end
  resources :rating, only: [:create]
  resources :comments, except: %i[index new edit show]
  root 'books#index'
end
