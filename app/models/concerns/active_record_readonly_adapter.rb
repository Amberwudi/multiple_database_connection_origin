# frozen_string_literal: true

module ActiveRecordReadonlyAdapter
  extend ActiveSupport::Concern

  included do
  end

  def delete
    _raise_readonly_record_error if readonly?
    super
  end

  def touch(*names, time: nil)
    _raise_readonly_record_error if readonly?
    super
  end

  private

  def readonly?
    true
  end
end
