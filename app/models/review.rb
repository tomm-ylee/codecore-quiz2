class Review < ApplicationRecord
  belongs_to :idea
  belongs_to :user

  validates :comment, presence: true
  
end
