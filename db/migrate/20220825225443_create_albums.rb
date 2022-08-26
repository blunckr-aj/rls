class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name

      t.timestamps
    end

    create_table :albums do |t|
      t.string :name
      t.string :artist
      t.references :store, foreign_key: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute 'GRANT SELECT ON schema_migrations TO rls_user'
        execute 'GRANT SELECT, INSERT, UPDATE, DELETE ON albums TO rls_user'
        execute 'GRANT SELECT, INSERT, UPDATE, DELETE ON stores TO rls_user'
        execute 'ALTER TABLE albums ENABLE ROW LEVEL SECURITY'
        execute "CREATE POLICY albums_rls_user ON albums TO rls_user USING (store_id = NULLIF(current_setting('rls.store_id', TRUE), '')::bigint)"
        execute 'GRANT USAGE, SELECT ON SEQUENCE albums_id_seq TO rls_user'
        execute 'GRANT USAGE, SELECT ON SEQUENCE stores_id_seq TO rls_user'
      end
      dir.down do
        execute 'REVOKE USAGE, SELECT ON SEQUENCE stores_id_seq FROM rls_user'
        execute 'REVOKE USAGE, SELECT ON SEQUENCE albums_id_seq FROM rls_user'
        execute 'DROP POLICY albums_rls_user ON albums'
        execute 'ALTER TABLE albums DISABLE ROW LEVEL SECURITY'
        execute 'REVOKE SELECT, INSERT, UPDATE, DELETE ON stores FROM rls_user'
        execute 'REVOKE SELECT, INSERT, UPDATE, DELETE ON albums FROM rls_user'
        execute 'REVOKE SELECT ON schema_migrations FROM rls_user'
      end
    end
  end
end
