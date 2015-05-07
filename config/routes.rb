Rails.application.routes.draw do
  root 'home#index'
  post 'check' => 'home#check_card'
  get 'index' => 'home#index'

  resources :cards, :decks
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'user_profile' => 'user_profile#edit'
  patch 'user_profile' => 'user_profile#update'
  
  get 'login' => 'user_sessions#new', :as => :login
  get 'signup' => 'user_registration#new', :as => :signup
  post 'signup' => 'user_registration#create'
  post 'logout' => 'user_sessions#destroy', :as => :logout

  delete 'decks' => 'user_profile#reset_current_deck', :as => :reset_current_deck
  put 'decks' => 'user_profile#set_current_deck', :as => :set_current_deck

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
