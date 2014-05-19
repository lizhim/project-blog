Blog::Application.routes.draw do
  root 'blog#login'

  post 'blog/validate_account_and_password' => 'blog#validate_account_and_password'

  get 'blog/post' => 'blog#post'

  get 'blog/manager' => 'blog#manager'

  get 'blog/category_manage' => 'blog#category_manage'

  get 'blog/detail' => 'blog#detail'

  get 'blog/edit' => 'blog#edit'

  delete 'blog/destroy' => 'blog#destroy'

  get 'blog/logout' => 'blog#logout'

  get 'blog/login' => 'blog#login'

  get 'blog/register' =>'blog#register'

  post 'blog/judge_password_repeat' => 'blog#judge_password_repeat'

  get 'blog/manage_user' => 'blog#manage_user'

  post 'blog/destroy_script/:account_id' => 'blog#destroy_script'

  post 'blog/destroy_publish/:account_id' => 'blog#destroy_publish'

  get 'blog/edit_publish/:account_id' => 'blog#edit_publish'

  post  'blog/edit_publish_save' => 'blog#edit_publish_save'

  get 'blog/edit_script/:account_id' => 'blog#edit_script'

  post  'blog/edit_script_save' => 'blog#edit_script_save'

  post 'blog/publish_script' => 'blog#publish_script'

  delete 'blog/destroy_user' => 'blog#destroy_user'

  post 'blog/save_script' => 'blog#save_script'

  post 'blog/publish' => 'blog#publish'

  get 'blog/script' => 'blog#script'

  get 'blog/add_user' => 'blog#add_user'

  post 'blog/judge_user_password_repeat' => 'blog#judge_user_password_repeat'

  get 'blog/recycle' => 'blog#recycle'

  #get 'blog/model' => 'blog#model'

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
