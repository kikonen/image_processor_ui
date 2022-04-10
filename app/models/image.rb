# frozen_string_literal: true

class Image < ApplicationModel
  attr_accessor :status, :url, :mime_type, :exif_values

  def initialize(data = {})
    super
  end
end
