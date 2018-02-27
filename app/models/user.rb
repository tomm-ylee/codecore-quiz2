class User < ApplicationRecord
  has_many :ideas, dependent: :nullify
  has_many :reviews, dependent: :nullify

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
