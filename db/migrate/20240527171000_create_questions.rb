class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :text
      t.integer :right_answer_id

      t.timestamps
    end
  end
end
