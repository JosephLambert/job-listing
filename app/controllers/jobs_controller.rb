class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :addfav, :quitfav]
    before_action :validate_search_key, only: [:search]
    def index
        @suggests = Job.published.random5
        if params[:category].present?
            @category = params[:category]
            if @category == '所有类型'
                @jobs = Job.published.recent.paginate(page: params[:page], per_page: 5)
            else
                @jobs = Job.where(is_hidden: false, category: @category).recent.paginate(page: params[:page], per_page: 5)
            end

        # 判断是否筛选薪水 #
        elsif params[:order].present?
            @wage = params[:order]
            if @wage == '薪资上限'
                @jobs = Job.published.order('wage_upper_bound DESC').paginate(page: params[:page], per_page: 5)
            else @wage == '薪资下限'
                 @jobs = Job.published.order('wage_lower_bound DESC').paginate(page: params[:page], per_page: 5)
            end

        # 预设显示所有公开职位 #
        else
            @jobs = Job.published.recent.paginate(page: params[:page], per_page: 5)
        end
  end

    def show
        @job = Job.find(params[:id])

        # 随机推荐五个相同类型的职位（去除当前职位） #
        @sames = Job.where(is_hidden: false, category: @job.category).where.not(id: @job.id).random5

        redirect_to root_path, alert: '此职缺暂未开放。' if @job.is_hidden
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
        @suggests = Job.published.random5
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
            flash[:notice] = '您已取消收藏此职位'
        else
            flash[:warning] = '你没有收藏此职位该怎么取消收藏此职位XD'

        end
        redirect_to :back
    end

    def votejob
        @job = Job.find(params[:id])
        if !current_user.voted_votes.include?(@job)
            current_user.voted_votes << @job
            flash[:notice] = '您成功对此职位点赞'
        else
            flash[:warning] = '同一个职位只能点赞一次哦'
          end
        redirect_to :back
    end

    protected

    def validate_search_key
        @query_string = params[:q].gsub(/\\|\'|\/|\?/, '') if params[:q].present?
        @search_criteria = search_criteria(@query_string)
    end

    def search_criteria(query_string)
        { title_or_location_or_company_or_category_cont: query_string }
    end

    private

    def job_params
        params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
    end
end
