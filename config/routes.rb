Rails.application.routes.draw do
  get 'home/index'
  resources :event_details do
    collection do
      get :game
    end
  end
  resources :games
  devise_for :users
  resources :events
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
