class FeedbacksController < ApplicationController
    def new
        @feedback = Feedback.new
    end

    def create
        @feedback = Feedback.new(feedback_params)
        if @feedback.save
            redirect_to root_path
            flash[:notice] = '成功提交反馈'
        else
            render :new
      end
    end

    private

    def feedback_params
        params.require(:feedback).permit(:name, :email, :comment)
    end
end
