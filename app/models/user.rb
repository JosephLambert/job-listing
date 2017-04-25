class User < ApplicationRecord
    has_many :resumes
    has_many :job_relationships
    has_many :applied_jobs, through: :job_relationships, source: :job

    has_many :favorites
    has_many :fav_relationships
    has_many :fav_jobs, through: :fav_relationships, source: :job

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    def admin?
        is_admin
    end

    def apply!(job)
        applied_jobs << job
    end

    def is_member_of_fav_jobs?(job)
        fav_jobs.include?(job)
    end

    def add_fav!(job)
        fav_jobs << job
    end

    def quit_fav!(job)
        fav_jobs.delete(job)
    end
end
