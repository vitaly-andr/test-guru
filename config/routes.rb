Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  namespace :admin do
    resources :tests do
      resources :questions, shallow: true do
        resources :answers, shallow: true
      end
    end
    resources :categories
    resources :users
    resources :gists, only: %i[index]
  end

  resources :tests, only: [:index] do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end
  resources :gists, only: %i[create]
  resources :feedbacks, only: [:new, :create]


end
