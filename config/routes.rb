Rails.application.routes.draw do
  get '/dashboard/orm', to: 'dashboard#orm', as: 'orm'
  get '/dashboard/slowdb', to: 'dashboard#slowdb', as: 'slowdb'
  get '/dashboard/slowrequest', to: 'dashboard#slowrequest', as: 'slowrequest'
  get '/dashboard/swallowedexception', to: 'dashboard#swallowedexception', as: 'swallowedexception'
  get '/dashboard/untracked', to: 'dashboard#untracked', as: 'untracked'

  post '/good_app/orm', to: 'good_app#orm', as: 'goodapp_orm'
  post '/good_app/slowdb', to: 'good_app#slowdb', as: 'goodapp_slowdb'
  post '/good_app/slowrequest', to: 'good_app#slowrequest', as: 'goodapp_slowrequest'
  post '/good_app/swallowedexception', to: 'good_app#swallowedexception', as: 'goodapp_swallowedexception'
  post '/good_app/untracked', to: 'good_app#untracked', as: 'goodapp_untracked'
  
  root 'dashboard#index'
end
