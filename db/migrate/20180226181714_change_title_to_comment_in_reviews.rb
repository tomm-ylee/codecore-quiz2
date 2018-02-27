class ChangeTitleToCommentInReviews < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :title, :comment
  end
end
