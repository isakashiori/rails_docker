Rails.application.routes.draw do
  namespace :staff do
    root "top#index"
    get 'login', to: 'sessions#new', as: :login
    post 'session', to: 'sessions#create', as: :session
    delete 'session', to: 'sessions#destroy'
  end

  namespace :admin do
    root "top#index"
    get 'login', to: 'sessions#new', as: :login
    post 'session', to: 'sessions#create', as: :session
    delete 'session', to: 'sessions#destroy'
  end

  namespace :customer do
    root "top#index"
  end
end


