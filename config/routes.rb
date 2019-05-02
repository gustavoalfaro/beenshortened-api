Rails.application.routes.draw do
  get 'top.json' => 'link_shortener#top'
  get '/*url' => 'link_shortener#index'
end
