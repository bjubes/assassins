Rails.application.routes.draw do
  resources :kill_confirmations
  match 'players/:id' => 'players#show', via: [:get]
  match 'players' =>'players#index', via: [:get]
  resources :team_requests do
    get 'accept'
    get 'deny'
  end
  resources :teams

  match 'kills/new', to: 'kill_confirmations#new', via: [:get]

  resources :kills

  get 'omniauth_callbacks/twitter'
  devise_for :users,
             controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root 'static_pages#home'
  match 'team_requests/accept' => 'team_requests#accept', via: [:post]
  match 'team_requests/deny' => 'team_requests#deny', via: [:post]

  match 'kills/new', to: 'kill_confirmations#new', via: [:get]
  #kill_confirmation state machine
  match 'kill_confirmations/:id/accept' => 'kill_confirmations#accept', via: [:post]
  match 'kill_confirmations/:id/deny' => 'kill_confirmations#deny', via: [:post]
  match 'kill_confirmations/:id/veto' => 'kill_confirmations#veto', via: [:post]
  match 'kill_confirmations/:id/approve' => 'kill_confirmations#approve', via: [:post]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
