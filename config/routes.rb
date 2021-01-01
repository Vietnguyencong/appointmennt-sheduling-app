Rails.application.routes.draw do
  resources :appointments do
    member do 
      put 'book', to: 'appointments#book'
      put 'unbook', to: 'appointments#unbook'
      put 'set_finish', to: 'appointments#set_finish'
      put 'set_un_finish', to: 'appointments#set_un_finish'
    end 
  end
  devise_for :users
  root "home#index"
  get 'home/index'
  get 'home/admin_view'
  get 'home/show_users'
  get 'home/user/:id', to: 'home#user', as: 'user' # show and edit only one user 
  # put 'home/upload_image/:id', to: 'home#upload_image', as: 'user_image' 
  resources :user do
    member do
      delete 'delete_image/:image_id', to: "user#delete_image", as: 'delete_user_image'
      put 'upload_image', to: 'user#upload_image', as:"upload_image"
      put 'set_main_image/:image_id', to: 'user#set_main_image', as:'main_image'
    end
  end
end
