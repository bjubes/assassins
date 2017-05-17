Rails.application.routes.draw do
  get 'omniauth_callbacks/twitter'

  devise_for :users,
             controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
