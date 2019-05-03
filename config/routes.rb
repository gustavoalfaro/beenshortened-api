Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :link_shortener, only: [:show, :create] do
        get :top, on: :collection
      end
    end
  end
end
