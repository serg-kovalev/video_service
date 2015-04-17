def stub_yt_video
  expect_any_instance_of(Yt::Video).to receive(:id).and_return('12345')
  expect_any_instance_of(Yt::Video).to receive(:title).and_return('title')
  expect_any_instance_of(Yt::Video).to receive(:like_count).and_return(1)
  expect_any_instance_of(Yt::Video).to receive(:dislike_count).and_return(0)
  expect_any_instance_of(Yt::Video).to receive(:published_at).and_return(Time.now)
end

class FakeUploadVideo
  def initialize failed = false
    @failed = failed
  end
  
  def id

  end

  def failed?
    @failed
  end
end
