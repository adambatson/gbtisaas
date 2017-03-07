Rails.application.routes.draw do
  resources :messages do
    member do
      get :unapprove
      get :approve
      get :upvote
      get :downvote
    end
  end

  resources :guestbooks do
    member do
      get :archive
      get :export
      get :set_default
      get :toggle_visibility
    end
  end

  resources :access_keys do
    member do
      get :assign
    end
  end

  resource  :session,
    :controller => 'sessions',
    :only => [:new, :create, :destroy]

  resource  :password,
    :controller => 'passwords',
    :only => [:new, :create, :destroy, :update]

  resource  :user,
    :controller => 'users',
    :only => [:create]

  post 'users/_create', to: 'users#_create'
  delete 'users/:id/_destroy', to: 'users#_destroy'


  get 'admin', to: 'guestbooks#admin'
  get 'admin/guestbooks', to: 'guestbooks#admin'

  get 'admin/signatures/:book_id', to: 'messages#admin'
  get 'admin/signatures', to: 'messages#admin'
  
  get 'admin/access', to: 'access_keys#admin'

  get 'admin/accounts', to: 'users#admin'

  root 'home#index'
  get '/view/:id', to: 'home#index'
  get 'about', to: 'home#about'
end
