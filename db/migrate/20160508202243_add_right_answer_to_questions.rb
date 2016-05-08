class AddRightAnswerToQuestions < ActiveRecord::Migration
  def change
    add_reference :answers, :right_answer, polymorphic: true, index: true

  end
end
