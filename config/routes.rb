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
    end
  end

  resources :access_keys do
    member do
      get :assign
    end
  end
  #get 'messages/:id/upvote' => 'messages#upvote'
  #get 'messages/:id/downvote' => 'messages#downvote'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get 'about', to: 'home#about'


  get 'admin', to: 'guestbooks#admin'
  get 'admin/guestbooks', to: 'guestbooks#admin'

  get 'admin/signatures/:book_id', to: 'messages#admin'
  get 'admin/signatures', to: 'messages#admin'
  
  get 'admin/access', to: 'access_keys#admin'

  get 'admin/accounts'
end
