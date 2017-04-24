class Account::JobsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :new, :create, :update, :edit, :destroy]

    def show
        @job = Job.find(params[:id])
    end

    def index
        @jobs = current_user.applied_jobs.recent.paginate(page: params[:page], per_page: 5)
    end
end
