# frozen_string_literal: true

class Upload < ApplicationModel
  attr_accessor :images

  def initialize(data = {})
    super
  end
end
