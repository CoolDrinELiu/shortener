class ShortUrl < ApplicationRecord
  before_save :generate_authentication_token, :if => :new_record?

  validates :target_url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :url, scope: [:target_url]
  validates_uniqueness_of :url, :target_url

  private
  def generate_authentication_token
    loop do
      squashed_url = Digest::MD5.hexdigest(target_url)[0..8]
      unless ShortUrl.where(url: squashed_url).first
        self.url = squashed_url
        break 
      end
    end
  end
end

