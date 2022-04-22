# frozen_string_literal: true

class UploadsController < ApplicationController
  def index
    @uploads = fetch_request_uploads
  end

  def show
    @upload = fetch_request_upload
  end

  def upload_images
    image_urls = params[:upload_images]
                   .gsub(/\s+/m, ' ')
                   .split(" ")
    image_urls.delete_if { |v| v.empty? }

    if image_urls.empty?
      redirect_to uploads_path
      return
    end

    upload_data = {
      upload: {
        images: image_urls.map { |url| { url: url } }
      }
    }

    api = ApiRequest.new
    response = api.post(
      url: "/uploads",
      token: fetch_request_token,
      body: upload_data)

    redirect_to uploads_path
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

  def protect_against_forgery?
    # TODO KI temp workaround due to error:
    # "HTTP Origin header (http://localhost:8121) didn't match request.base_url (http://localhost)"
#    false
    super
  end

  private

  def fetch_request_uploads
    api = ApiRequest.new
    response = api.get(
      url: "/uploads",
      token: fetch_request_token)
    return [] unless response.success?
    response.content&.map { |data| Upload.new(data) } || []
  end

  def fetch_request_upload
    upload_id = params[:id]
    api = ApiRequest.new

    response = api.get(
      url: "/uploads/#{upload_id}",
      token: fetch_request_token)
    return nil unless response.success?
    data = response.content
    data[:images] = data[:images]&.map { |img_data| Image.new(img_data) }
    Upload.new(data)
  end
end
