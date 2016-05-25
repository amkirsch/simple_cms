class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string :name, null: false
      t.string :permalink, null: false
      t.integer :position, null: false
      t.boolean :visible, default: true
      t.integer :section_id

      t.timestamps null: false
    end
    add_foreign_key :subjects, :pages
  end

  def down
    drop_table :pages
  end
end
