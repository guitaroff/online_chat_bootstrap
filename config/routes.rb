Rails.application.routes.draw do
  devise_for :users
  root to: 'home#show'

  resources :rooms, only: %i[index show create], param: :title
  resources :messages, only: :create
  resources :users, only: :show
end
