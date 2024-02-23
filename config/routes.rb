Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # You can define the root route if you have a controller and action to handle it
  # root "categories#index"

  # Routes for categories
  resources :categories do
    # Nested routes for tasks within categories
    resources :tasks do
      member do
        patch 'mark_complete', to: 'tasks#mark_complete'
        patch 'mark_incomplete'
      end
    end
  end

  # If you want a route to list all tasks across categories that are due today, you can add a collection route
  get 'tasks/due_today', to: 'tasks#due_today', as: :due_today_tasks

  # If you want to have routes for tasks that are not nested you can also declare it outside of categories
  # This would provide routes like /tasks/:id independent of categories
  # resources :tasks
end
