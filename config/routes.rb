require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedIn.new do
    root "dashboards#show", as: :dashboard
  end

  constraints Monban::Constraints::SignedOut.new do
    root "sessions#new"
  end

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :listings do
    resources :bookings, only: [:new, :create, :destroy]
  end
end
