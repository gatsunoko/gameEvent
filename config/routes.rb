Rails.application.routes.draw do
  get 'home/index'
  resources :event_details do
    collection do
      get :game
      get :tag_search
    end
  end
  resources :games do
    member do
      get :up
      get :down
    end
  end
  devise_for :users
  resources :events
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
