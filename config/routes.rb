Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: 'statics#top'

  resources :unread_books do
    patch :reading, on: :member
    get :reading_books, on: :collection
    patch :return, on: :member
    get :search, on: :collection
  end

  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index create]
  end

  resources :finished_books do
    get :others, on: :collection
    get :disposal, on: :collection
  end

  resources :comments, only: :create
  resources :users, only: :show
  resources :concern_books, only: [:create, :destroy]
  resources :progresses, only: [:create, :destroy]
end
