# frozen_string_literal: true

module Hers
  class ApplicationRecord < ActiveRecord::Base
    include DatabaseConnectionResetExtension
    include ActiveRecordReadonlyAdapter

    self.abstract_class = true
    reset_database_connection(namespace: 'hers', multiple: false)
  end
end
