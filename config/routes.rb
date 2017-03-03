Rails.application.routes.draw do
  resources :messages do
    member do
      get :upvote
      get :downvote
    end
  end
  resources :guestbooks do
    member do
      get :set_default
    end
  end
  #get 'messages/:id/upvote' => 'messages#upvote'
  #get 'messages/:id/downvote' => 'messages#downvote'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get 'about', to: 'home#about'

  get 'admin', to: 'admin#guestbooks'
  get 'admin/guestbooks'
  get 'admin/signatures'
  get 'admin/access'
  get 'admin/accounts'
end
