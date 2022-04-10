# frozen_string_literal: true

class ImagesController < ApplicationController
  def show
    @image = fetch_request_image
  end

  def fetch_request_image
    image_id = params[:id]
    request = ApiRequest.new
    data = request.get(
      url: "/images/#{image_id}",
      token: fetch_request_token)

    data[:exif_values] = data[:exif_values]&.map { |exif_data| ExifValue.new(exif_data) }
    Image.new(data)
  end
end
