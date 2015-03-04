Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post '/rate' => 'rater#create', :as => 'rate'

  devise_for :users, controllers: { :sessions => "users/sessions", :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations"}

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users do
    resources :reviews
  end
  resources :playdates
  resources :events

  get '/', to: 'events#home', as: :home
  get 'users/:id/questionnaire', to: 'users#questionnaire', as: :questionnaire
  get '/suggestmedates', to: 'playdates#suggest', as: :suggest

  put 'users/:id/update_preferences', to: 'users#update_preferences', as: :update_preferences

  put 'users/:id/create_match', to: 'users#create_match', as: :create_match

  root 'events#home'

end
