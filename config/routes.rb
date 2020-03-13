Rails.application.routes.draw do
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new, :show, :edit]
  resources :sessions, only: [:new]
  resources :favorites, only: [:show]
end
