class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  SET_CUSTOMER_ID_SQL = 'SET rls.store_id = %s'.freeze
  RESET_CUSTOMER_ID_SQL = 'RESET rls.store_id'.freeze
  def self.with_store_id(store_id, &block)
    if store_id
      connection.execute format(SET_CUSTOMER_ID_SQL, connection.quote(store_id))
    end
    block.call
  ensure
    if store_id
      connection.execute RESET_CUSTOMER_ID_SQL
    end
  end
end
