# frozen_string_literal: true

module His
  class Base < ActiveRecord::Base
    include DatabaseConnectionResetExtension
    include ActiveRecordReadonlyAdapter

    self.abstract_class = true
    reset_database_connection(namespace: 'his', multiple: true)
  end
end
