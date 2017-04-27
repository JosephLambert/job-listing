Rails.application.routes.draw do
    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :jobs do
        member do
            post :addfav
            post :quitfav
            post :votejob
        end
        collection do
            get :search
        end
        resources :resumes
    end

    namespace :account do
        resources :jobs
        resources :favorites
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
