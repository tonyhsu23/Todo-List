ToDo::Application.routes.draw do
  devise_for :users
  resources :lists do
    member do
      get 'count'
    end
    resources :todos
  end
  root to: "lists#index"
end
