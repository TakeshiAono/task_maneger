Rails.application.routes.draw do
  get 'sessions/new'
  root to: "tasks#index"
  resources :tasks do
    collection do
      get :sort
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
