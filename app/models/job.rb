class Job < ApplicationRecord
    has_many :resumes, dependent: :destroy
    has_many :job_relationships, dependent: :destroy
    has_many :members, through: :job_relationships, source: :user

    has_many :favorites, dependent: :destroy
    has_many :fav_relationships, dependent: :destroy
    has_many :favors, through: :fav_relationships, source: :user

    has_many :votes
    has_many :vote_relationships
    has_many :voted_users, through: :vote_relationships, source: :user

    validates :title, presence: { message: '请填写职称' }
    validates :description, presence: { message: '请填写职位描述' }
    validates :wage_upper_bound, presence: { message: '请填写薪资上限' }
    validates :wage_lower_bound, presence: { message: '请填写薪资下限' }
    validates :wage_lower_bound, numericality: { greater_than: 0, message: '薪资下限必须大于零' }
    validates :wage_upper_bound, numericality: { greater_than: :wage_lower_bound, message: '薪资上限必须大于薪资下限' }
    validates :contact_email, presence: { message: '请填写联系邮箱' }
    validates_format_of :contact_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: '请输入正确的邮箱格式'
    validates :company, presence: { message: '请填写公司名称' }
    validates :location, presence: { message: '请填写公司所在城市' }
    validates :category, presence: { message: '请填写职位类别' }

    def publish!
        self.is_hidden = false
        save
        end

    def hide!
        self.is_hidden = true
        save
    end

    scope :published, -> { where(is_hidden: false) }

    scope :recent, -> { order('created_at DESC') }

    scope :random5, -> { limit(5).order('RANDOM()') }
end
