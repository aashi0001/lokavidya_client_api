Rails.application.routes.draw do
  resources :users, only: [:index,:show, :create, :update, :destroy] do
  	collection do
  		get 'verify'
  		get 'find'
  	end
  end
  get "/find" => "users#find", :as=> :find
  post "/signup" => "users#create", :as => :signup
  post "/update" => "users#update", :as => :update
  get "/delete" => "users#destroy", :as => :delete
  get "/logout" => "session#destroy", :as => :logout
  post "/login" => "session#create", :as => :login
  get "/forgot" => "password_reset#create", :as => :forgot
  post "/reset" => "password_reset#update", :as => :reset
  get "/fb" => "social#create", :as => :fb
  resources :validate, only: [:index]
  resources :password_reset, only:[:create, :update]
  resources :session, only: [:create,:destroy]
  resources :social, only:[:create]
end
