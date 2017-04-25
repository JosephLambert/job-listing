class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :addfav, :quitfav]
    before_action :validate_search_key, only: [:search]
    def index
        @jobs = case params[:order]
                when 'by_lower_bound'
                    Job.published.order('wage_lower_bound DESC').paginate(page: params[:page], per_page: 5)

                when 'by_upper_bound'
                    Job.published.order('wage_upper_bound DESC').paginate(page: params[:page], per_page: 5)

                else
                    Job.published.recent.paginate(page: params[:page], per_page: 5)

    end
  end

    def show
        @job = Job.find(params[:id])

        flash[:warning] = 'This Job already archieved' if @job.is_hidden
    end

    def new
        @job = Job.new
    end

    def create
        @job = Job.new(job_params)
        if @job.save
            redirect_to jobs_path
        else
            render :new
        end
    end

    def edit
        @job = Job.find(params[:id])
    end

    def update
        @job = Job.find(params[:id])

        if @job.update(job_params)
            redirect_to jobs_path
        else
            render :edit
        end
    end

    def destroy
        @job = Job.find(params[:id])
        @job.destroy
        redirect_to jobs_path, alert: 'Job deleted '
    end

    def search
        if @query_string.present?
            search_result = Job.published.ransack(@search_criteria).result(distinct: true)
            @jobs = search_result.recent.paginate(page: params[:page], per_page: 5)
      end
    end

    def addfav
        @job = Job.find(params[:id])
        if !current_user.is_member_of_fav_jobs?(@job)
            current_user.add_fav!(@job)
            flash[:notice] = '您成功收藏此职位'
        else
            flash[:warning] = '你已收藏此职位'

        end
        redirect_to :back
        end

    def quitfav
        @job = Job.find(params[:id])
        if  current_user.is_member_of_fav_jobs?(@job)
            current_user.quit_fav!(@job)
            flash[:notice] = '您成功取消收藏此职位'
        else
            flash[:warning] = '你没有收藏此职位该怎么取消收藏此职位XD'

        end
        redirect_to :back
    end

    protected

    def validate_search_key
        @query_string = params[:q].gsub(/\\|\'|\/|\?/, '') if params[:q].present?
        @search_criteria = search_criteria(@query_string)
    end

    def search_criteria(query_string)
        { title_or_location_or_company_cont: query_string }
    end

    private

    def job_params
        params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
    end
end
