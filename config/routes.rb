Rails.application.routes.draw do
  #get '/', to: 'home#index'
  root to: 'home#index'
  resources :manufacturers
end
