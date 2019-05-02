Rails.application.routes.draw do
  get '/*url' => 'link_shortener#index'
end
