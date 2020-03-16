Rails.application.routes.draw do
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
end
