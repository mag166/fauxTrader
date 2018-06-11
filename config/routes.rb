Rails.application.routes.draw do
  get 'transactions/index'
  get 'user_companies/index'
  get 'companies/index'
  get 'users/index'

  post 'users/index' => "companies#create"
  post 'companies/index' => "companies#create"
  post 'companies/:id' => "transactions#create"


  root 'users#index'

  resources :companies
  resources :transactions


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
