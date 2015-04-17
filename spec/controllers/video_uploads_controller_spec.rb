require 'rails_helper'

RSpec.describe VideoUploadsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    allow_any_instance_of(Authorization).to receive(:fetch_details_from_facebook)
    allow_any_instance_of(Authorization).to receive(:fetch_details_from_google_oauth2) 
    @user.authorizations << FactoryGirl.create(:facebook_auth)
    @user.authorizations << FactoryGirl.create(:google_oauth2)
    allow_any_instance_of(User).to receive(:has_google_connection?).and_return(true)
    sign_in @user
  end

  it 'should show a form' do
    get :new
    expect(response).to be_success
  end

  it 'should upload a file to a server' do
    fake_upload_video = FakeUploadVideo.new false
    allow_any_instance_of(VideoUpload).to receive(:save).and_return(true)
    allow_any_instance_of(VideoUpload).to receive(:upload!).with(@user).and_return(fake_upload_video)
    allow_any_instance_of(Video).to receive(:add_details).and_return(true)
    post :create, video_upload: { 
      title: 'title', description: 'descr', 
      file: Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'ajax-loader.gif'), 'text/gif') }
    expect(subject).to redirect_to root_url
  end

  it 'should show errors if upload was not successful' do
    allow_any_instance_of(VideoUpload).to receive(:save).and_return(false)
    post :create, video_upload: { 
      title: 'title', description: 'descr', 
      file: Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'ajax-loader.gif'), 'text/gif') }
    expect(response).to be_success
    expect(subject).to render_template(:new)
  end
end
