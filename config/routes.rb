Rails.application.routes.draw do
	root to: 'users#index'

  devise_for :users

  resources :accounts
  resources :transactions
end
