class AddRightAnswerFlagToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :right_answer, :boolean, default: false
  end
end
