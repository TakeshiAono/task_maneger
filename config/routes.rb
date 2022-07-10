Rails.application.routes.draw do
  root to: "tasks#index"
  resources :sessions do
    collection do
      get 'login'
    end
  end
  resources :tasks do
    collection do
      get :sort
    end
  end
  resources :users
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
