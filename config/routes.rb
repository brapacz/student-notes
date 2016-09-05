Rails.application.routes.draw do
  devise_for :users
  resources :students do
    get :subjects
  end
  resources :teachers
  resources :report_subjects

  root to: 'students#index'
end
