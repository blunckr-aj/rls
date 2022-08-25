class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :artist
      t.string :store_id

      t.timestamps
    end
  end
end
