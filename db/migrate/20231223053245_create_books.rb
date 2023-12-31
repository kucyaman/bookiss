class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :design_type, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
