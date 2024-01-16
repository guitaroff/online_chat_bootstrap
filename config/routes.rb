Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'

  resources :rooms, only: %i[index show create], param: :title
  resources :messages, only: :create
end
