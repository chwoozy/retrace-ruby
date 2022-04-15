Rails.application.routes.draw do
  get '/dashboard/orm', to: 'dashboard#orm', as: 'orm'
  get '/dashboard/slowdb', to: 'dashboard#slowdb', as: 'slowdb'
  get '/dashboard/slowrequest', to: 'dashboard#slowrequest', as: 'slowrequest'
  get '/dashboard/swallowedexception', to: 'dashboard#swallowedexception', as: 'swallowedexception'
  get '/dashboard/untracked', to: 'dashboard#untracked', as: 'untracked'

  post '/bad_app/orm', to: 'bad_app#orm', as: 'badapp_orm'
  post '/bad_app/slowdb', to: 'bad_app#slowdb', as: 'badapp_slowdb'
  post '/bad_app/slowrequest', to: 'bad_app#slowrequest', as: 'badapp_slowrequest'
  post '/bad_app/swallowedexception', to: 'bad_app#swallowedexception', as: 'badapp_swallowedexception'
  post '/bad_app/untracked', to: 'bad_app#untracked', as: 'badapp_untracked'
  
  root 'dashboard#index'
end
