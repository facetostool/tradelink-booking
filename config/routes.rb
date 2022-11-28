Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/health', to: 'health#show'

  namespace :api do
    namespace :v1 do
      resources :bookings, only: [:index, :create]
      resources :time_ranges, only: [:index]
    end
  end
end
