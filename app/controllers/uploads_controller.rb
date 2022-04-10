# frozen_string_literal: true

class UploadsController < ApplicationController
  def index
    @uploads = fetch_request_uploads
  end

  def show
    @upload = fetch_request_upload
  end

  def fetch_request_uploads
    request = ApiRequest.new
    uploads_data = request.get(
      url: "/uploads",
      token: fetch_request_token)
    uploads_data&.map { |data| Upload.new(data) } || []
  end

  def fetch_request_upload
    upload_id = params[:id]
    request = ApiRequest.new

    data = request.get(
      url: "/uploads/#{upload_id}",
      token: fetch_request_token)
    data[:images] = data[:images]&.map { |img_data| Image.new(img_data) }
    Upload.new(data)
  end
end
