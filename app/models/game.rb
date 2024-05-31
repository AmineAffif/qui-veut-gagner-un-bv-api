class Game < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :questions

  validates :score, numericality: { only_integer: true }

  after_save :update_user_global_score

  private

  def update_user_global_score
    user.statistic.calculate_global_score
    user.statistic.set_rank
    user.statistic.save
  end
end
