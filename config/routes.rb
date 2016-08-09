Rails.application.routes.draw do
  root 'homes#index'
  resource :object_records, only: [:create, :destroy]
  resources :object_snapshots, only: [:create]
end
