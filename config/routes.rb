Rails.application.routes.draw do

  resources :photos

  match 'photos' => 'photos#create', via: [:post, :patch]

  get '/entity', to: redirect('/')

  resources :advertisements, :path => 'entity' do
    member do
      get 'top'
    end
    collection do
      get 'get_attributes'
      get 'get_search_attributes'
      get 'check_phone'
      get 'get_locations'
    end
  end
  mount RailsAdmin::Engine => '/management', as: 'rails_admin'
  match '/' => 'advertisements#index', via: [:get]
  devise_for :users

  namespace :api do
    resources :validation
    resources :locations
    resources :advertisements, :path => '/entity' do
      collection do
        get 'streets_houses'
      end
    end
  end

  get '/:url', :to => "advertisements#index", :constraints => { :url => /[^\.]*/, :format => 'html' }


  root 'advertisements#index'



end
