require "picturelife_exporter/version"
require "picturelife_exporter/api"
require "picturelife_exporter/file_downloader"
require "picturelife_exporter/cli"

module PicturelifeExporter
  def self.download_images(destination:, cookie:, access_token:)
    api = API.new(access_token)
    image_info = api.image_ids(per_page: 20000, page: 0)
    image_ids = image_info.fetch(:ids)
    total_images = image_ids.size

    image_ids.each_with_index do |image_id, index|
      image_number = index + 1
      puts "Downloading image #{image_number} / #{total_images}"
      download_image(image_id: image_id,
                     destination: destination,
                     cookie: cookie
                    )
    end
  end

  def self.download_image(image_id:, destination:, cookie:)
    url = URI("http://picturelife.com/d/original/#{image_id}")
    response = 
      PicturelifeExporter::FileDownloader.
      download(url: url,
               destination: "#{destination}#{image_id}",
               cookie: cookie)
  end
end
