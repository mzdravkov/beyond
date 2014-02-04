Beyond::Engine.routes.draw do
  devise_for :users, :class_name => "Beyond::User", module: :devise
  root :to => "tenants#new"

  resources :plugins, only: [:new, :create]

  resources :tenants, only: [:new, :create, :edit, :update, :show]
  post '/tenants/:id/stop', to: 'tenants#stop'
  post '/tenants/:id/start', to: 'tenants#start'
  resources :plugins, only: [:new, :create]
  post '/plugins/:id/stop', to: 'plugins#stop', as: 'plugin_stop'
  post '/plugins/:id/start', to: 'plugins#start', as: 'plugin_start'
end
