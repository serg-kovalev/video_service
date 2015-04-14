Rails.application.routes.draw do
  devise_for :users
  
  root 'video_upload#index'
end
