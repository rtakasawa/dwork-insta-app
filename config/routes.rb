Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
end
