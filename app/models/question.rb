class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :right_answer, class_name: 'Answer', optional: true
  has_and_belongs_to_many :games
  has_many :user_questions, dependent: :destroy
  has_many :users, through: :user_questions


  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :text, presence: true
end
