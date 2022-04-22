# frozen_string_literal: true

class ImagesController < ApplicationController
  def show
    @image = fetch_request_image
  end

  def fetch
    @image = fetch_request_image

    api = ApiRequest.new
    response = api.post(
      url: "/images/#{@image.id}/fetch",
      token: fetch_request_token)

    head :no_content
  end

  private

  def fetch_request_image
    image_id = params[:id]
    response = ApiRequest.new.get(
      url: "/images/#{image_id}",
      token: fetch_request_token)
    return unless response.success?

    data = response.content
    data[:exif_values] = data[:exif_values]&.map { |exif_data| ExifValue.new(exif_data) }
    Image.new(data)
  end
end
