Rails.application.routes.draw do
  # namespace :staff, path: "" do 
  #   root "top#index"
  #   get 'login', to: 'sessions#new', as: :login
  #   resource :session, only: [ :create, :destroy ]
  #   resource :account, except: [ :new, :create, :destroy ]
  # end

  constraints host: "baukis2.example.com" do
    namespace :staff, path: "" do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ]
    end
  end

  namespace :admin do
    root "top#index"
    get 'login', to: 'sessions#new', as: :login
    post 'session', to: 'sessions#create', as: :session
    delete 'session', to: 'sessions#destroy'
    resource :session, only: [ :create, :destroy ]
    resources :staff_members
  end

  namespace :customer do
    root "top#index"
  end
end


