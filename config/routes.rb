Swampcrash::Application.routes.draw do
  resources :quizzes do
    member do
      get :answer
      post :answer
      resources :quiz_questions
      get :grade_answers
      post :grade_answers
      delete :delete_answer_sheet
      get :reveal_question
      put :publish
      put :complete
    end
  end

  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'me', :as=>:current_user, :controller=>:user, :action=>:index, :via=>:get
  match 'me', :as=>:current_user, :controller=>:user, :action=>:update, :via=>[:post, :put]
  match 'content/:action', :as=>:content, :controller=>:content
  match 'sitemap.xml' => "content#sitemap"
  match 'feed/atom.xml' => "content#atom_feed"
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
  root :to => "quizzes#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
