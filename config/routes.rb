Rails.application.routes.draw do
  root 'homes#index'
  resources :object_records, only: [:create]
  resources :object_snapshots, only: [:create]
end
