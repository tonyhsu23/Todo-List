ToDo::Application.routes.draw do
  devise_for :users
  resources :lists do
    resources :todos
  end
  root to: "lists#index"
end
