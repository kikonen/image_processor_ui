# frozen_string_literal: true

class Image < ApplicationModel
  STATUS_NEW = 'new'
  STATUS_FETCHED = 'fetched'

  attr_accessor :status, :url, :mime_type, :exif_values

  def initialize(data = {})
    super
  end

  def fetched?
    self.status == STATUS_FETCHED
  end
end
