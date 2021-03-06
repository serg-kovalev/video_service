class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!

  def all
    Rails.logger.info env['omniauth.auth'].inspect
    user = User.from_omniauth(env['omniauth.auth'], current_user)
    if user.persisted?
      flash[:notice] = I18n.t('messages.logged_in')
      sign_in_and_redirect(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
    #handle you logic here..
    #and delegate to super.
    super
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end
