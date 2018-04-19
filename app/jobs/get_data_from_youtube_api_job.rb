class GetDataFromYoutubeApiJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    fetch_and_load_data
  end


  private

  def initialize_video_record(data)
    video = Video.new
    video.title = data[:title]
    video.description = data[:description]
    video.tags = data[:tags]
    video.save!
  end

  def put_tags_to_string(tags_array)
    res = ''
    tags_array&.each do |tag|
      res += tag + ' '
    end
    res
  end

  def fetch_and_load_data(next_page_token = nil)
    begin
      url = 'https://www.googleapis.com/youtube/v3/videos?key=AIzaSyDVvs9Gj4iUHOsQFnVng7EjibvWKPStOVo&part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&videoCategoryId=10'
      url += "&pageToken=#{next_page_token}" unless next_page_token.nil?
      puts url
      data = JSON.parse(Net::HTTP.get(URI.parse(url)))
      items = data['items']

      videos = []
      items.each do |i|
        if i['kind'] == 'youtube#video'
          videos << i['snippet']
        end
      end

      videos.each do |v|
        hash = {
          title: v['title'],
          description: v['description'],
          tags: put_tags_to_string(v['tags'])
        }
        initialize_video_record(hash)
      end
      puts data['nextPageToken']
      fetch_and_load_data(data['nextPageToken']) if data['nextPageToken'].present?
    rescue Exception => e
      puts e
      puts e.backtrace
    end
  end
end
