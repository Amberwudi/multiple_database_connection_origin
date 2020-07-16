# frozen_string_literal: true

module DatabaseConnectionResetExtension
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    # ActiveRecord::Base.configurations is different with Rails.application.config.database_configuration
    def reset_database_connection(namespace: nil, multiple: false)
      config = begin
        if namespace.present?
          if multiple
            Rails.application.config_for("database_#{namespace}")
          else
            configurations.try(:[], namespace.to_s).try(:[], Rails.env) ||
              Rails.application.config.database_configuration.try(:[], namespace.to_s).try(:[], Rails.env) ||
              configurations.try(:[], "#{namespace}_#{Rails.env}") ||
              Rails.application.config.database_configuration.try(:[], "#{namespace}_#{Rails.env}")
          end
        else
          configurations.try(:[], Rails.env) ||
            Rails.application.config.database_configuration.try(:[], Rails.env)
        end
      end
      if config.blank?
        raise "Database configuration could not be blank! Parameters: { namespace: #{namespace.inspect}, multiple: #{multiple.inspect} }."
      end
      establish_connection(config)
    rescue StandardError => e
      Rails.logger.error('Could not connect to the database!')
      Rails.logger.error("Configuration: #{config}.") if config.present?
      Rails.logger.error(e)
      Rails.logger.error(e.backtrace.join("\n"))
    end
  end
end
