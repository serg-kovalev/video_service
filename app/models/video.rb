class Video < ActiveRecord::Base
  belongs_to :user
  before_save :add_details

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  validates :link, presence: true, format: YT_LINK_FORMAT

  private
  def add_details
    video = Yt::Video.new auth: user.get_yt_connection, url: link
    Rails.logger.info video.inspect
    self.uid = video.id
    self.title = video.title
    self.likes = video.like_count
    self.dislikes = video.dislike_count
    self.published_at = video.published_at
  rescue Yt::Errors::NoItems
    resource.title = ''
  end
end
