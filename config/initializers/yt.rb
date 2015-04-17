Yt.configure do |config|
  config.client_id = ENV['GOOGLE_KEY']
  config.client_secret = ENV['GOOGLE_SECRET']
  # config.log_level = :debug
end
