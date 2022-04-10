# frozen_string_literal: true

class Image < ApplicationModel
  attr_accessor :status, :url, :mime_type

  def initialize(data = {})
    super
  end
end
