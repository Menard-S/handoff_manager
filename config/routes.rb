Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  get '/dashboard', to: 'dashboard#index'
  get "up" => "rails/health#show", as: :rails_health_check 
  resources :categories do
    resources :tasks do
      member do
        patch 'mark_complete', to: 'tasks#mark_complete'
        patch 'mark_incomplete'
      end
    end
  end
end
