# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :link_shortener, only: %i[show create] do
        get :top, on: :collection
      end
    end
  end
end
