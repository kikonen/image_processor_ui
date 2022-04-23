# frozen_string_literal: true

class User < ApplicationModel
  NULL_ID   = '00000000-0000-0000-0000-000000000000'
  SYSTEM_ID = '11111111-1111-1111-1111-111111111111'

  attr_accessor :email

  def initialize(data = {})
    super
  end

  def valid?
    self.id != NULL_ID
  end

  def system_user?
    valid? && self.id == SYSTEM_ID
  end

  def normal_user?
    valid? && !system_user?
  end

  def self.system_user
    @system_user ||= User.new(
      id: User::SYSTEM_ID,
      email: 'system@local')
  end

  def self.null_user
    @null_user ||= User.new(
      id: User::NULL_ID,
      email: 'n/a')
  end

end
