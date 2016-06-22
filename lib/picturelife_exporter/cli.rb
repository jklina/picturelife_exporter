require 'thor'
require 'pry'

module PicturelifeExporter
  class CLI < Thor
    include Thor::Actions
    class_option :cookie, required: true

    desc "download_images", "downloads all your images from picturelife"
    option :api_token, required: true 
    def download_images(destination)
      cookie = options.fetch('cookie')
      api_token = options.fetch('api_token')
      empty_directory(destination)
      PicturelifeExporter.download_images(destination: destination,
                                         cookie: cookie,
                                         access_token: api_token)
    end

    desc "download_image", "downloads an image given image_id"
    option :destination
    def download_image(image_id)
      destination = options.fetch('destination') { '.' }
      cookie = options.fetch('cookie')
      empty_directory(destination)
      PicturelifeExporter.download_image(destination: destination,
                                        image_id: image_id,
                                        cookie: cookie)
    end
  end
end
