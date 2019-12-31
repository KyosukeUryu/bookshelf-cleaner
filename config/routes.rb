Rails.application.routes.draw do
  devise_for :users
  root to: 'unread_books#tops'

  resources :unread_books
end
