Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    resources :requests, only: [:new, :create]
  end

  resources :requests, only: [:show, :edit, :update] do
    resources :entries, except: [:show, :destroy]
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:show]

  patch '/requests/:id/accept', to: 'requests#accept', as: 'accept_request'
  patch '/requests/:id/reject', to: 'requests#reject', as: 'reject_request'

  get '/dashboard', to: 'pages#dashboard'

end
