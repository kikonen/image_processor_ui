class ApplicationModel
  include ActiveModel::API

  attr_accessor :data

  attr_accessor :id, :created_at, :updated_at

  def initialize(data = {})
    @data = data

    data&.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end
end
