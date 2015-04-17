require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @auth = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '12346',
        credentials: OmniAuth::AuthHash.new(token: '1234asd123', secret: 'sdfdsfdsf'),
        info: OmniAuth::AuthHash::InfoHash.new(
          name: @user.name,
          email: @user.email,
          nickname: ''
        )
    )
    @auth2 = @auth.dup
    @auth2.provider = 'google_oauth2'
    allow_any_instance_of(Authorization).to receive(:fetch_details_from_facebook)
    allow_any_instance_of(Authorization).to receive(:fetch_details_from_google_oauth2)  
  end

  context 'omniauth redirect' do
    it 'should find correct user from_omniauth (Facebook)' do
      @user.authorizations << FactoryGirl.create(:facebook_auth)
      user = User.from_omniauth(@auth, nil)
      user.save
      expect(user.authorizations.first).to_not be_nil
      expect(@user.id).to eq(user.id)
    end

    it 'should find correct user from_omniauth (Google)' do
      @user.authorizations << FactoryGirl.create(:google_oauth2)
      user = User.from_omniauth(@auth2, nil)
      user.save
      expect(user.authorizations.first).to_not be_nil
      expect(@user.id).to eq(user.id)
    end

    it 'should create new user from_omniauth (Facebook)' do
      @auth.info.email = 'test@at222.me'
      FactoryGirl.create(:facebook_auth)
      user = User.from_omniauth(@auth, nil)
      user.save
      expect(user.authorizations.first).to_not be_nil
      expect(@user.id).to_not eq(user.id)
    end

    it 'should create new user from_omniauth (Google)' do
      @auth2.info.email = 'test@at223.me'
      FactoryGirl.create(:google_oauth2)
      user = User.from_omniauth(@auth2, nil)
      user.save
      expect(user.authorizations.first).to_not be_nil
      expect(@user.id).to_not eq(user.id)
    end
  end

  context 'the rest methods' do
    before do
      @user.authorizations << FactoryGirl.create(:google_oauth2)
      @user = User.from_omniauth(@auth2, nil)
      @user.save
    end

    it 'should return google connection' do
      auth = @user.google_auth
      expect(auth).to_not be_nil
      expect(auth.token).to_not be_blank
    end

    it 'should return true if Yt connection' do
      allow_any_instance_of(User).to receive(:has_google_connection?).and_return(true)
      @user.instance_variable_set('@account', 'Yt_account')
      expect(@user.get_yt_connection).to eq('Yt_account')
    end
  end
end
