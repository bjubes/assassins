Rails.application.routes.draw do
  resources :team_requests
  get 'omniauth_callbacks/twitter'

  devise_for :users,
             controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root 'static_pages#home'
  resources :teams

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
