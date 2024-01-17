Rails.application.routes.draw do
  devise_for :users
  root to: 'home#show'

  resources :rooms, only: %i[show create], param: :title
  resources :messages, only: :create
end
