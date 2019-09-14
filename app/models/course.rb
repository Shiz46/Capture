class Course < ApplicationRecord
  belongs_to :user
  has_many :sections, dependent: :delete_all


  validates :title, presence: true
  validates :description, presence: true
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}
end