Rails.application.routes.draw do
  root 'homes#index'
  resources :object_records, only: [:new, :create]
  resource :object_snapshots, only: [:create]
end
