class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      # Foreign key to subjects table
      t.integer "subject_id"
      t.string :name, null: false
      t.string :permalink, null: false
      t.integer :position, null: false
      t.boolean :visible, default: false

      t.timestamps null: false
    end
    # Always add indexes to foreign keys
    add_index "pages", "subject_id"
    # Indexed because the permalink will need to be accessed frequently,
    # however do this only when needed!
    add_index "pages", "permalink"

  end

  def down
    drop_table :pages
  end
end
