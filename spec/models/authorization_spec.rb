require 'rails_helper'

RSpec.describe Authorization, type: :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  it 'should create facebook auth for user' do
    expect_any_instance_of(Authorization).to receive(:fetch_details_from_facebook).once
    auth = Authorization.create(
      :provider => 'facebook', 
      :uid => '12345', 
      :token => 'sdfdsfsdfsfsdfs', 
      :secret => 'asdqwxcvdfg',
      :user_id => @user.id)
    expect(auth.persisted?).to eq true
    expect(auth.user_id).to eq @user.id
    expect(auth.provider).to eq 'facebook'
  end

  it 'should create google_oauth2 auth for user' do
    expect_any_instance_of(Authorization).to receive(:fetch_details_from_google_oauth2).once
    auth = Authorization.create(
      :provider => 'google_oauth2', 
      :uid => '12345', 
      :token => 'sdfdsfsdfsfsdfs', 
      :secret => 'asdqwxcvdfg',
      :user_id => @user.id)
    expect(auth.persisted?).to eq true
    expect(auth.user_id).to eq @user.id
    expect(auth.provider).to eq 'google_oauth2'
  end
end
