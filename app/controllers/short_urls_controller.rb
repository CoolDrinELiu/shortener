class ShortUrlsController < ApplicationController
  before_action :set_record, only: [:enabled, :disabled]

  def index
    @records = ShortUrl.all
  end

  def show
    r = ShortUrl.find_by_url(params[:id])
    if r.present? && r.target_url.present? && r.active
      r.increment!(:clicks)
      redirect_to r.target_url
    else
      render file: '/public/404.html', status: '404'
    end
  end

  def new
    @record = ShortUrl.new
  end

  def create
    @record = ShortUrl.new(permitted_params)
    if @record.save
      redirect_to short_urls_path
    else
      @unstable = true
      render :new
    end
  end

  def enabled
    if @record.update(active: true)
      redirect_to short_urls_path
    end
  end

  def disabled
    if @record.update(active: false)
      redirect_to short_urls_path
    end
  end

  private
  
  def permitted_params
    params.require(:short_url).permit(*%w{target_url})
  end

  def set_record
    @record = ShortUrl.find(params[:id])
  end
end
