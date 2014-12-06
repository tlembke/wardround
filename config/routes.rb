Wardround::Application.routes.draw do
  
 
  
  # replace devise_for :users with:
  devise_for :users,  :controllers => { :registrations => "users/registrations" }
  

  root :to => "rounds#index"
  
  resources :claims
  
  resources :reports

  resources :rounds do
      member do
        get 'return'
      end
    end

  resources :visits do
      collection do
        post 'remove'
        post 'charge'
        post 'uncharge'
      end
    end


  resources :patients  do
      member do
        post 'discharge'
        post 'undischarge'
        post 'decrement'
        post 'changeward'
        post 'changestatus'
        post 'under'
        post 'transfer'
      end
    end
  
  resources :hospitals do
    collection do
      get 'wards_by_hospital'
    end
    member do
      get 'report'
      get 'handover'
    end
  end
  
  resources :wards
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
