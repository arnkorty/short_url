lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "test/unit"
require 'short_url'
ShortUrl.config do |config|
  config.redis     = Redis.new
  config.token_key = 'token'
end
class TestPost < Test::Unit::TestCase
  def test_short_url_md5
    url       = "http://baidu.com/test"
    short_url =ShortUrl.generate(url, type: :md5)
    assert_equal(url,ShortUrl.get_url(short_url),'This test about multiply is failure!')
  end

  def test_short_url_random
    url       = "http://baidu.com/test"
    short_url = ShortUrl.generate(url, type: :random)
    assert_equal(url,ShortUrl.get_url(short_url),'This test about multiply is failure!')
  end

  def test_diff_url_md5
    url1      = "http://baidu.com/test"
    url2      = "http://baidu.com/fsdgsdg"
    short_url1 = ShortUrl.generate(url1, type: :md5)
    short_url2 = ShortUrl.generate(url2, type: :md5)
    assert_not_equal(short_url1, short_url2,'This test about multiply is failure!')
  end

  def test_diff_url_random
    url1      = "http://baidu.com/test"
    url2      = "http://baidu.com/fsdgsdg"
    short_url1 = ShortUrl.generate(url1, type: :random)
    short_url2 = ShortUrl.generate(url2, type: :random)
    assert_not_equal(short_url1, short_url2,'This test about multiply is failure!')
  end

  def test_diff_url_random_md5
    url1      = "http://baidu.com/test"
    url2      = "http://baidu.com/fsdgsdg"
    short_url1 = ShortUrl.generate(url1, type: :random)
    short_url2 = ShortUrl.generate(url2, type: :md5)
    assert_not_equal(short_url1, short_url2,'This test about multiply is failure!')
  end


end