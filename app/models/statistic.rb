class Statistic < ApplicationRecord
  belongs_to :user

  enum rank: {
    beginner: 'Beginner',
    intermediate: 'Intermediate',
    advanced: 'Advanced',
    expert: 'Expert',
    master: 'Master'
  }

  def calculate_global_score
    self.global_score = user.games.sum(:score)
  end

  def set_rank
    self.rank = case global_score
                when 0..100
                  'beginner'
                when 101..200
                  'intermediate'
                when 201..300
                  'advanced'
                when 301..400
                  'expert'
                else
                  'master'
                end
  end
end
