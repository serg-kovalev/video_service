class VideoUpload < ActiveType::Object
  attribute :file, :varchar
  attribute :title, :varchar
  attribute :description, :text

  validates :file, presence: true
  validates :title, presence: true

  def upload!(user)
    account = user.get_yt_connection
    account.upload_video self.file, title: self.title, description: self.description
  end
end
