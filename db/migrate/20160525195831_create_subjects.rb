class CreateSubjects < ActiveRecord::Migration
  def up
      create_table :subjects do |t|
      t.string :name, null: false
      t.integer :position, null: false
      t.boolean :visible, default: true, null: false
      t.integer :page_id, limit: 11
      t.integer :section_id, limit: 11

      t.timestamps null: false
    end
  end

  def down
    drop_table :subjects
  end
end
