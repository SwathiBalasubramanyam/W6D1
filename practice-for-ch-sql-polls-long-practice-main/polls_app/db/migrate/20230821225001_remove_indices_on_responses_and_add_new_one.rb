class RemoveIndicesOnResponsesAndAddNewOne < ActiveRecord::Migration[7.0]
  def change
    remove_index :responses, column: :answer_choice_id
    remove_index :responses, column: :question_id
    remove_index :responses, column: :user_id

    add_index :responses, [:answer_choice_id, :user_id], unique:true
    remove_column :responses, :question_id
  end
end
