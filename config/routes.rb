Rails.application.routes.draw do
  resources :requests, only: [:new, :create, :show]
  root 'requests#new'
end
