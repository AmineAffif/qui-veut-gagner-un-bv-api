class CreateGamesQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :games_questions do |t|
      t.references :game, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
