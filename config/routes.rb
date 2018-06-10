Rails.application.routes.draw do
  get 'transactions/index'
  get 'user_companies/index'
  get 'companies/index'
  get 'users/index'

  root 'users#splash'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
