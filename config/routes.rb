Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :session, only: [:new, :destroy, :create]
  resources :subs
  resources :posts
end
