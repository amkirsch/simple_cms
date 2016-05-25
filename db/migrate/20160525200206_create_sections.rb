class CreateSections < ActiveRecord::Migration
  def up
    create_table :sections do |t|
      t.string :name, null: false
      t.integer :position, null: false
      t.boolean :visible, default: true, null: false
      t.string :content_type, null: false
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :pages, :sections
    add_foreign_key :subjects, :sections
  end

  def down
    drop_table :sections
  end
end
