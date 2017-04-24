class ChangeCommentStyleToFeedback < ActiveRecord::Migration[5.0]
    def change
        change_column(:feedbacks, :comment, :text)
    end
end
