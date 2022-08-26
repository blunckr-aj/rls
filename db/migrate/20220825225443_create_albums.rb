class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute 'GRANT SELECT ON schema_migrations TO rls_user'
      end
      dir.down do
        execute 'REVOKE SELECT ON schema_migrations FROM rls_user'
      end
    end

    create_table :albums do |t|
      t.string :name
      t.string :artist
      t.string :store_id

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute 'GRANT SELECT, INSERT, UPDATE, DELETE ON albums TO rls_user'
      end
      dir.down do
        execute 'REVOKE SELECT, INSERT, UPDATE, DELETE ON albums FROM rls_user'
      end
    end

    reversible do |dir|
      dir.up do
        execute 'ALTER TABLE albums ENABLE ROW LEVEL SECURITY'
        execute "CREATE POLICY albums_rls_user ON albums TO rls_user USING (store_id = NULLIF(current_setting('rls.store_id', TRUE), ''))"
        execute "GRANT USAGE, SELECT ON SEQUENCE albums_id_seq TO rls_user"
      end
      dir.down do
        execute 'DROP POLICY albums_rls_user ON albums'
        execute 'ALTER TABLE albums DISABLE ROW LEVEL SECURITY'
      end
    end
  end
end
