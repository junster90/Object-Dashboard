Rails.application.routes.draw do
  root 'object_snapshots#index'
  resources :object_snapshots, only: [:index, :new, :create]
end
