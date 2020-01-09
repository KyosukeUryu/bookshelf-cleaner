Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'unread_books#tops'

  resources :unread_books do
    patch :reading, on: :member
    get :reading_books, on: :collection
    patch :return, on: :member
    get :search, on: :collection
  end

  resources :conversations do
    resources :messages
  end

  resources :finished_books do
    get :others_books, on: :collection
  end

  resources :comments, only: [:create]
  resources :users, only: [:show]
  resources :concern_books, only: [:create, :destroy]
  resources :progresses, only: [:create, :destroy]
end
