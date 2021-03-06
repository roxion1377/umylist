UnlimitedMylist::Application.routes.draw do
  get "apis/new"
  get "movies/new"
  get "mylists/index"
  get "mylists/show"
  get "mylists/new"
  get "mylists/edit"
  post "mylists/remove" => "mylists#destroy"
  get "mylists" => "mylists#index"
#  get "mylists/:id" => "mylists#show"
  post "mylists/rename" => "mylists#rename"
#  post "my"
  get "sessions/new"
#  get "users/index"
#  get "users/show"
#  get "users/new"
#  get "users/edit"
  get 'signup' => 'users#new', :as => :signup
  get 'signin' => 'sessions#new', :as => :signin
  get 'signout' => 'sessions#destroy', :as => :signout
  post 'movies' => "movies#create"
  post 'movies/remove' => 'movies#remove'

  resources :users
  resources :sessions
  resources :mylists
#  resources :movies

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
