class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      # Foreign key
      t.integer "page_id"
      t.string :name, null: false
      t.integer :position, null: false
      t.boolean :visible, default: false, null: false
      t.string :content_type, null: false
      t.text :content

      t.timestamps null: false
    end
    # Index for foreign key
    add_index :sections, "page_id"
  end

end
