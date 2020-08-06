Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  resources :event_details, path: 'e' do
    collection do
      get :game
      get :search
    end
    member do
      get :duplication
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
  resources :users, :only => [:index, :show, :edit, :update] do 
    member do
      get :role_edit
      patch :role_update
    end
  end

  resources :events

  resources :information_provisions, :only => [:index, :show, :new, :create, :destroy]

  resources :pokes do
    collection do
      get :auto_complete
      get :pokemon
      get :pokecheck
      get :poke_check_search
      get :poke_search
    end
  end
end
