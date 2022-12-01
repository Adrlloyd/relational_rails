Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/leagues', to: 'leagues#index'
  get '/leagues/:id', to: 'leagues#show'
  get '/clubs', to: 'clubs#index'
end
