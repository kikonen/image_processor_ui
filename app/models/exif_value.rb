# frozen_string_literal: true

class ExifValue < ApplicationModel
  attr_accessor :key, :value

  def initialize(data = {})
    super
  end
end
