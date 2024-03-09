Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#index'
  get "up" => "rails/health#show", as: :rails_health_check
  root "registrations#new"
  get 'sign_up', to: 'registrations#new', as: :sign_up
  post 'sign_up', to: 'registrations#create'
  delete 'logout', to: "sessions#destroy"
  get 'sign_in', to: 'sessions#new', as: :sign_in
  post 'sign_in', to: 'sessions#create'


  resources :categories do
    resources :tasks do
      member do
        patch 'mark_complete', to: 'tasks#mark_complete'
        patch 'mark_incomplete'
      end
    end
  end
end
