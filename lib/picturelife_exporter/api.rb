require "httparty"

module PicturelifeExporter
  class API
    include HTTParty
    base_uri 'http://api.picturelife.com'
    format :json

    def initialize(access_token)
      @access_token = access_token
    end

    def all_images(per_page:)
      per_page = Integer(per_page)

      page = 0
      total_pages = 0
      image_ids = []
      while(page <= total_pages) do
        image_data = image_ids(per_page: per_page, page: page)
        total_pages = image_data.fetch(:total_pages)
        page += 1
        image_ids += image_data.fetch(:ids)
      end

      return image_ids
    end

    def get_album(image_id:)
      albums = 
        self.class.
        get("/medias/albums/", 
            { query: 
              {access_token: @access_token,
               media_id: image_id,
              }
            }
           )

        return albums.fetch('albums').first.fetch('caption')
    end

    def image_ids(per_page:, page:)
      per_page = Integer(per_page)
      page = Integer(page)
      offset = page * per_page

      image_data = 
        self.class.
        get("/medias/index/", 
            { query: 
              {access_token: @access_token,
               ids_only: true,
               limit: per_page,
               offset: offset
              }
            }
           )

      ids = image_data.fetch("media")
      total_pages = Integer(image_data.fetch("total") / per_page)
      return { ids: ids, total_pages: total_pages }
    end
  end
end
