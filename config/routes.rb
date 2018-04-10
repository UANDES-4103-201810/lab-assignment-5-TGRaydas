Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/places/most_assistance', to: "places#most_assistance"
  get '/events/unpaid_tickets', to: "events#unpaid_tickets_event"
  get '/events/expensive_tickets/:id', to: "events#most_expensive_tickets"
  resources :users
  resources :events
  resources :places
  resources :tickets
  resources :users do
    resources :user_tickets
  end
  get '/users/user_ticket/best_users', to: "users#best_users"


end
