Rails.application.routes.draw do
  root 'static_page#home'

  get 'help'      => 'static_page#help'
  get 'about'     => 'static_page#about'
  get 'contact'   => 'static_page#contact'
  get 'signup'    => 'users#new'

  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
end
