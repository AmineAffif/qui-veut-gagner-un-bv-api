class CreateStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :statistics do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :global_score, default: 0
      t.string :rank

      t.timestamps
    end
  end
end
