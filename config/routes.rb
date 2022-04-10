# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :uploads, only: [:index, :show] do
    member do
      get :fetch_images
    end
  end

  resources :images, only: [:show] do
    member do
      get :fetch
    end
  end

  # Defines the root path route ("/")
  root "uploads#index"
end
