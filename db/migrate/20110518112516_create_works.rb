class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.integer :user_id
      t.binary :image_file
      t.string :image_content_type
      t.integer :image_file_size
      t.timestamp :image_updated_at
      t.string :image_file_name
      t.binary :image_medium_file
      t.binary :image_thumb_file

      t.timestamps

      t.timestamps
    end
  end

  def self.down
    drop_table :works
  end
end
