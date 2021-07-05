Rails.application.routes.draw do
  root 'comics#index'

  namespace :api do
    namespace :v1 do
      get 'comics', to: 'comics#index'
    end
  end
end
