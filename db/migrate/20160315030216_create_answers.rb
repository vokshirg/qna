class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :question_id
      t.timestamps
    end

    add_index :answers, :question_id
  end
end
