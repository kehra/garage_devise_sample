Rails.application.routes.draw do
  use_doorkeeper
  use_doorkeeper

  devise_for :users

  scope :api do
    resources :users
  end
end
