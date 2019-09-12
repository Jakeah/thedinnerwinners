Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :teams
  get '/admin_utility/import_schedule', to: 'admin_utility#import_schedule', as: 'admin_utility_import_schedule'
  post '/admin_utility/import_schedule_csv', to: 'admin_utility#import_schedule_csv', as: 'admin_utility_import_schedule_csv'
end
