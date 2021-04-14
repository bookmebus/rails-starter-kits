Rails.application.routes.draw do
  
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  scope "/(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :companies
    resources :tenants
    resources :users

    namespace :quote do
      resources :submissions
    end

    namespace :api, defaults: {format: :json} do
      devise_for :users, :controllers => {sessions: 'api/sessions', registrations: 'api/registrations'}
    end
  end

  get '/:locale' => 'home#index'
end
