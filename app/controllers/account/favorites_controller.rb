class Account::FavoritesController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :new, :create, :update, :edit, :destroy]
    def index
        @jobs = current_user.fav_jobs.recent.paginate(page: params[:page], per_page: 5)
    end
end
