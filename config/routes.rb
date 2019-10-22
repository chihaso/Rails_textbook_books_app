# frozen_string_literal: true

Rails.application.routes.draw do
  get "users/show"
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: "books#index"
  resources :users, only: [:show]
end
