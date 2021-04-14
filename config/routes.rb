Rails.application.routes.draw do

  # https://github.com/rails/rails/pull/34477#issuecomment-651467261
  direct :cdn_proxy do |model, options|
    if model.respond_to?(:signed_id)
      route_for(
        :rails_service_blob_proxy,
        model.signed_id,
        model.filename,
        options.merge(host: ENV['ACTIVE_STORAGE_CDN'])
      )
    else
      signed_blob_id = model.blob.signed_id
      variation_key  = model.variation.key
      filename       = model.blob.filename

      route_for(
        :rails_blob_representation_proxy,
        signed_blob_id,
        variation_key,
        filename,
        options.merge(host: ENV['ACTIVE_STORAGE_CDN'])
      )
    end
  end if ENV['ACTIVE_STORAGE_CDN'].present?
  
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
