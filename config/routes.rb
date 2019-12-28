Rails.application.routes.draw do
  root to: 'not_done_books#tops'

  resources :not_done_books
end
