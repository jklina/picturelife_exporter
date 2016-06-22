require 'net/http'
require 'ruby-progressbar'

module PicturelifeExporter
  module FileDownloader

    def self.download(url:, destination:, limit: 10, cookie:)
      progressbar = ProgressBar.create
      uri = URI(url)

      raise ArgumentError, 'too many HTTP redirects' if limit == 0

      req = Net::HTTP::Get.new(uri)
      req['Cookie'] = cookie
      completed_request_size = 0

      begin
        response = Net::HTTP.start(uri.hostname) do |http|
          http.request req do |response|
            case response
            when Net::HTTPRedirection then
              location = response['location']
              warn "redirected to #{location}"
              download(url: location,
                       destination: destination,
                       limit: limit - 1,
                       cookie: cookie)
            when Net::HTTPSuccess then
              destination += extract_extension(response.uri.path)
              total_request_size = response.content_length
              puts "Saving File: #{destination}"
              bar = ProgressBar.create(title: "Items",
                                       starting_at: 0,
                                       format: '%a %B %p%% %r KB/sec',
                                       rate_scale: lambda { |rate| rate / 1024 },
                                       total: total_request_size)
              open destination, 'w' do |io|
                response.read_body do |chunk|
                  bar.progress += chunk.length
                  io.write chunk
                end
              end
            else
              response.value
            end
          end
        end
      rescue Exception => ex
        puts "Error Downloading File: #{ex.class} - #{ex.message}"
      end
    end

    private

    def self.extract_extension(file_name)
      File.extname(file_name) 
    end
  end
end
