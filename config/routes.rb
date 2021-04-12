Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :destroy, :create, :show]
  resources :subs
  resources :posts
end
