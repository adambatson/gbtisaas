Rails.application.routes.draw do
  resources :messages do
    member do
      get :upvote
      get :downvote
    end
  end
  resources :guestbooks
  #get 'messages/:id/upvote' => 'messages#upvote'
  #get 'messages/:id/downvote' => 'messages#downvote'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
