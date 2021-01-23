module ShortUrlsHelper
  def status_txt state
    state.present? ? 'Active' : 'Inactive'
  end
end
