class Job < ApplicationRecord
    has_many :resumes
    has_many :job_relationships
    has_many :members, through: :job_relationships, source: :user

    has_many :favorites
    has_many :fav_relationships
    has_many :favors, through: :fav_relationships, source: :user

    validates :title, presence: true
    validates :wage_upper_bound, presence: true
    validates :wage_lower_bound, presence: true
    validates :wage_lower_bound, numericality: { greater_than: 0 }

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
