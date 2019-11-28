Rails.application.routes.draw do
  #get '/', to: 'home#index'
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
end
