class Statistic < ApplicationRecord
  belongs_to :user

  enum rank: {
    beginner: 'Beginner',
    intermediate: 'Intermediate',
    advanced: 'Advanced',
    expert: 'Expert',
    master: 'Master'
  }

  after_save :update_rank

  def calculate_global_score
    self.global_score = user.games.sum(:score)
  end

  def set_rank
    self.rank = case global_score
                when 0..100
                  'Beginner'
                when 101..200
                  'Intermediate'
                when 201..300
                  'Advanced'
                when 301..400
                  'Expert'
                else
                  'Master'
                end
  end

  private

  def update_rank
    set_rank
    update_column(:rank, rank) if rank_changed?
  end
end
