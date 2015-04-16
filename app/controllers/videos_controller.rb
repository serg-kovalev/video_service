class VideosController < ApplicationController
  before_action :check_connection, except: [:new]

  def index
    @videos = Video.order('created_at DESC')
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.user = current_user
    if @video.save
      flash[:success] = 'Video added!'
      redirect_to root_url
    else
      render :new
    end
  end

  private
  def check_connection
    if current_user.has_google_connection?
      @account = current_user.get_yt_connection
    else
      @account = nil
      flash[:warning] = t('messages.please_auth_via_google', link: t('labels.authorize')).html_safe
      redirect_to action: :new
    end
  end

  def video_params
    params.require(:video).permit(:link)
  end
end
