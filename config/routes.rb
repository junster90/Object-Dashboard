Rails.application.routes.draw do
  root 'object_records#index'
  resources :object_records, only: [:index, :new, :create]
end
