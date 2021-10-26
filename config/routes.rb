Rails.application.routes.draw do
  resources :expenses
  resources :savings
  root 'dashboards#index'
end
