Rails.application.routes.draw do

  resources :photos

  match 'photos' => 'photos#create', via: [:post, :patch]
  resources :advertisements, :path => 'entity' do
    collection do
      get 'get_attributes'
      get 'check_phone'
      get 'get_locations'
    end
  end
  mount RailsAdmin::Engine => '/management', as: 'rails_admin'
  match '/' => 'advertisements#index', via: [:get]
  devise_for :users

  namespace :api do
    resources :advertisements, :path => '/entity'
  end

  get '/:url', :to => "advertisements#index", :constraints => { :url => /.*/ }


  root 'advertisements#index'


end
