Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: "users/registrations" }

  # # Routes for the Contact resource:
  # # NEW
  root 'contacts#new'
  resources :contacts, only: [:new, :create]

  # Routes for the Choice resource:
  # CREATE
  get "/choices/new", :controller => "choices", :action => "new"
  post "/create_choice", :controller => "choices", :action => "create"

  # READ
  get "/choices", :controller => "choices", :action => "index"
  get "/choices/:id", :controller => "choices", :action => "show"

  # UPDATE
  get "/choices/:id/edit", :controller => "choices", :action => "edit"
  post "/update_choice/:id", :controller => "choices", :action => "update"
  post "/up_rank/:id", :controller => "choices", :action => "rank_up"

  # DELETE
  get "/delete_choice/:id", :controller => "choices", :action => "destroy"
  #------------------------------


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
