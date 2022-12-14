class ApplicationController < ActionController::Base
  around_action :with_customer_id

  def with_customer_id
    ApplicationRecord.with_store_id(session[:store_id]) do
      yield
    end
  end
end
