class Admin::FeedbacksController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :new, :create, :update, :edit, :destroy]
    before_filter :require_is_admin
    layout 'admin'

    def index
        @feedbacks = Feedback.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    end

    def destroy
        @feedback = Feedback.find(params[:id])
        @feedback.destroy
        redirect_to admin_feedbacks_path
    end
end
