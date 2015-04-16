class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  validates_presence_of :email
  has_many :authorizations, dependent: :destroy
  has_many :videos, dependent: :destroy

  def self.new_with_session(params,session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def google_auth
    authorizations.google_auth(id).limit(1).first
  end
  
  def has_google_connection?
    unless self.google_auth.nil?
      @account = Yt::Account.new access_token: google_auth.token unless 
        @account && @account.access_token == google_auth.token
      begin
        @account.email
        true
      rescue Yt::Errors::Unauthorized => e
        false
      end
    end
  end

  def get_yt_connection
    @account if has_google_connection?
  end

  def self.from_omniauth(auth, current_user)
    data = auth.info
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    
    if authorization.user.blank?
      user = current_user || User.where('email = ?', data.email).first
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.name = data.name
        user.email = data.email
        user.save
      end
      
      authorization.username = data.nickname
      authorization.user_id = user.id
      authorization.save
      # remove outdated authorizations
      Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s).order(:updated_at).all[0..-2].each(&:destroy)
    end

    authorization.user
  end
end
