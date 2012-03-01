require "goiu_shorten/version"
require "goiu_shorten/goiu_shorten_api"

module GoiuShorten
  def self.expand(short_url)
    GoiuShortenApi.new.expand(short_url)
  end
  def self.shorten(long_url, passcode)
    GoiuShortenApi.new.shorten(long_url, passcode)
  end
end
