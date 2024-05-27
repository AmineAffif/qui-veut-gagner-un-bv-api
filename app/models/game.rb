class Game < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :questions

  validates :score, numericality: { only_integer: true }
end
