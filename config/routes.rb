Rails.application.routes.draw do
  root :to => "nodes#index"

  devise_for :users, :controllers => { registrations: 'registrations' }, path_names: {sign_in: "login", sign_out: "logout"}
  resources :users do
    member {patch 'edit' => 'users#update'}
  end

  mount Mercury::Engine => '/'

  resources :nodes, :only => :none do
    collection {get  ':dg/index' => 'nodes#index', as: 'dg'}
    member {get 'edit' => 'nodes#edit'}
    member {patch 'edit' => 'nodes#update'}

    resources :themes, :only => :destroy, :shallow => :true do
      collection {get 'index' => 'themes#index'}
      end
  end
  resources :themes,  :only => :none do
    member {post :mercury_update}
    member {get  'new', to: redirect {|params| "/editor/themes/#{params[:id]}/create"}, as: 'redirect'}
    member {get 'create' => 'themes#new_entry'}
    member {post 'create' => 'themes#create', as: 'mercury_create'}
    member {get 'update' => 'themes#edit', as: 'update'}
    member {get 'show' => 'themes#show', as: 'show'}
    member {post 'update' => 'themes#mercury_update'}
    member {match 'check_com' => 'themes#check', via: [:patch]}
    member {match 'check_dg' => 'themes#check', via: [:patch]}
  end

    resources :searches,  :only => :none do
      collection {match 'simple' =>  "searches#simple", via: [:get, :post]}
      collection {match 'complex' => "searches#complex", via: [:get, :post]}
      get 'show_original' => 'searches#show_original', as: 'original'
    end

    resources :metadata,  :only => :none do
      member {get '/update' => 'metadata#edit'}
      member {match '/update' => 'metadata#update', via: :patch}
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
