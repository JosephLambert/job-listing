class Feedback < ApplicationRecord
    validates :name, presence: { message: '请填写姓名' }
    validates :email, presence: { message: '请填写邮箱' }
    validates :comment, presence: { message: '请填写问题或者建议' }
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: '请输入正确的邮箱格式'
end
