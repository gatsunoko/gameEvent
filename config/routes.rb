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
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    confirmations: 'users/confirmations',
                                    sessions: "users/sessions",
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :events
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
