# frozen_string_literal: true

module Yours
  class ApplicationRecord < ActiveRecord::Base
    include DatabaseConnectionResetExtension
    include ActiveRecordReadonlyAdapter

    self.abstract_class = true
    reset_database_connection(namespace: 'yours', multiple: true)
  end
end
