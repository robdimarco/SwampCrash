Swampcrash::Application.routes.draw do
  resources :quizzes do
    member do
      get :answer
      post :answer
      resources :questions
      get :grade_answers
      post :grade_answers
      delete :delete_answer_sheet
      put :publish
      put :complete
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
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
#== Route Map
# Generated on 30 Dec 2012 22:24
#
#                          POST     /quizzes/:id/answer(.:format)              quizzes#answer
#                questions GET      /quizzes/:id/questions(.:format)           questions#index
#                          POST     /quizzes/:id/questions(.:format)           questions#create
#             new_question GET      /quizzes/:id/questions/new(.:format)       questions#new
#            edit_question GET      /quizzes/:id/questions/:id/edit(.:format)  questions#edit
#                 question GET      /quizzes/:id/questions/:id(.:format)       questions#show
#                          PUT      /quizzes/:id/questions/:id(.:format)       questions#update
#                          DELETE   /quizzes/:id/questions/:id(.:format)       questions#destroy
#       grade_answers_quiz GET      /quizzes/:id/grade_answers(.:format)       quizzes#grade_answers
#                          POST     /quizzes/:id/grade_answers(.:format)       quizzes#grade_answers
# delete_answer_sheet_quiz DELETE   /quizzes/:id/delete_answer_sheet(.:format) quizzes#delete_answer_sheet
#             publish_quiz PUT      /quizzes/:id/publish(.:format)             quizzes#publish
#            complete_quiz PUT      /quizzes/:id/complete(.:format)            quizzes#complete
#                  quizzes GET      /quizzes(.:format)                         quizzes#index
#                          POST     /quizzes(.:format)                         quizzes#create
#                 new_quiz GET      /quizzes/new(.:format)                     quizzes#new
#                edit_quiz GET      /quizzes/:id/edit(.:format)                quizzes#edit
#                     quiz GET      /quizzes/:id(.:format)                     quizzes#show
#                          PUT      /quizzes/:id(.:format)                     quizzes#update
#                          DELETE   /quizzes/:id(.:format)                     quizzes#destroy
#         new_user_session GET      /users/sign_in(.:format)                   devise/sessions#new
#             user_session POST     /users/sign_in(.:format)                   devise/sessions#create
#     destroy_user_session DELETE   /users/sign_out(.:format)                  devise/sessions#destroy
#  user_omniauth_authorize          /users/auth/:provider(.:format)            users/omniauth_callbacks#passthru {:provider=>/facebook|twitter|google_apps/}
#   user_omniauth_callback          /users/auth/:action/callback(.:format)     users/omniauth_callbacks#(?-mix:facebook|twitter|google_apps)
#            user_password POST     /users/password(.:format)                  devise/passwords#create
#        new_user_password GET      /users/password/new(.:format)              devise/passwords#new
#       edit_user_password GET      /users/password/edit(.:format)             devise/passwords#edit
#                          PUT      /users/password(.:format)                  devise/passwords#update
# cancel_user_registration GET      /users/cancel(.:format)                    devise/registrations#cancel
#        user_registration POST     /users(.:format)                           devise/registrations#create
#    new_user_registration GET      /users/sign_up(.:format)                   devise/registrations#new
#   edit_user_registration GET      /users/edit(.:format)                      devise/registrations#edit
#                          PUT      /users(.:format)                           devise/registrations#update
#                          DELETE   /users(.:format)                           devise/registrations#destroy
#             current_user GET      /me(.:format)                              user#index
#             current_user POST|PUT /me(.:format)                              user#update
#                  content          /content/:action(.:format)                 content#:action
#                                   /sitemap.xml(.:format)                     content#sitemap
#                                   /feed/atom.xml(.:format)                   content#atom_feed
#                     root          /                                          quizzes#index
