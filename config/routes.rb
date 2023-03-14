Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'

  resources :posts do
    resources :comments
  end

  resources :attachments, only: :destroy
end
