Rails.application.routes.draw do
    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :jobs do
        resources :resumes
        collection do
            get :search
        end
    end

    namespace :account do
        resources :jobs
    end

    namespace :admin do
        resources :jobs do
            member do
                post :publish
                post :hide
            end
            resources :resumes
        end
        resources :feedbacks
    end

    resources :feedbacks

    get 'aboutus', to: 'welcome#aboutus'

    get 'contactus', to: 'welcome#contactus'

    get 'cooperatewithus', to: 'welcome#cooperatewithus'

    root 'welcome#index'
end
