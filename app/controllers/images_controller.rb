# frozen_string_literal: true

class ImagesController < ApplicationController
  def show
    @image = fetch_request_image
  end

  def fetch_request_image
    image_id = params[:id]
    request = ApiRequest.new
    request.get(url: "/images/#{image_id}")
  end
end
