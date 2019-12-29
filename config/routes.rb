Rails.application.routes.draw do
  devise_for :users
  root to: 'not_done_books#tops'

  resources :not_done_books
end
