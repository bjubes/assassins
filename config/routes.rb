Rails.application.routes.draw do
  resources :kill_confirmations
  match 'players/:id' => 'players#show', via: [:get]
  match 'players' =>'players#index', via: [:get]
  resources :team_requests do
    get 'accept'
    get 'deny'
  end
  resources :teams
  resources :kills

  get 'omniauth_callbacks/twitter'
  devise_for :users,
             controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root 'static_pages#home'
  match 'team_requests/accept' => 'team_requests#accept', via: [:post]
  match 'team_requests/deny' => 'team_requests#deny', via: [:post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
