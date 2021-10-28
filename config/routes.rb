Rails.application.routes.draw do
  devise_for :users
  resources :expenses
  resources :savings
  root 'dashboards#index'
  delete 'logout', to: 'sessions#destroy'
end
