# frozen_string_literal: true

class UploadsController < ApplicationController
  def index
    @uploads = fetch_request_uploads
  end

  def show
    @upload = fetch_request_upload
  end

  def fetch_images
    @upload = fetch_request_upload

    api = ApiRequest.new
    @upload.images.each do |image|
      response = api.post(
        url: "/images/#{image.id}/fetch",
        token: fetch_request_token)
    end

    head :no_content
  end

  private

  def fetch_request_uploads
    api = ApiRequest.new
    uploads_data = api.get(
      url: "/uploads",
      token: fetch_request_token)
    uploads_data&.map { |data| Upload.new(data) } || []
  end

  def fetch_request_upload
    upload_id = params[:id]
    api = ApiRequest.new

    data = api.get(
      url: "/uploads/#{upload_id}",
      token: fetch_request_token)
    data[:images] = data[:images]&.map { |img_data| Image.new(img_data) }
    Upload.new(data)
  end
end
