# frozen_string_literal: true

class User < ApplicationModel
  SYSTEM_ID = '00000000-0000-0000-0000-000000000000'

  attr_accessor :name

  def initialize(data = {})
    super
  end

  def system_user?
    self.id == SYSTEM_ID
  end

  def normal_user?
    !system_user?
  end
end
