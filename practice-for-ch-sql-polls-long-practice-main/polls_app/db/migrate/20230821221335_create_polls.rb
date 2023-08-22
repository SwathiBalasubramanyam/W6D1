class CreatePolls < ActiveRecord::Migration[7.0]
  def change
    create_table :polls do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.text :title, null: false, unique: true
      t.timestamps
    end
  end
end
