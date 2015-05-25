Rails.application.routes.draw do
  root 'nodes#index'
  
  get  'themes/:id/index' => 'themes#index', as: 'themes'
  
  resources :metadata, :only => [:update]
  
  resources :themes, :only => [:destroy, :show, :update] do
    member {post :mercury_update}
  end
     
  mount Mercury::Engine => '/'
  get  'themes/:id/new', to: redirect {|params| "/editor/themes/#{params[:id]}/create"}, as: 'redirect'
  get  'themes/:id/create' => 'themes#new_entry'
  post 'themes/:id/create' => 'themes#create', as: 'mercury_create'  
  get  'themes/:id/update' => 'themes#edit', as: 'update'
  post 'themes/:id/update' => 'themes#mercury_update'
     
  get  'nodes/index' => 'nodes#index', as: 'nodes'
  get  'searches/index' => 'searches#index', as: 'search'
  
  resources :nodes   do
    collection { post :search, to: 'nodes#index' }
  end
  
  
  
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
