require 'redis'
require 'digest'
class ShortUrl
  # Your code goes here...s
  class ConfigError < StandardError; end
  class UrlError    < StandardError; end
  class << self
    attr_accessor :token_key, :type, :max_rand
    attr_writer   :redis
    attr_reader   :base_url
    URL_CHARS      = ((48..57).to_a +  (65..90).to_a + (97..122).to_a).map{|n| n.chr}
    URL_CHARS_SIZE = URL_CHARS.size
    MAX_RAND       = 100
    def config
      if block_given?
        yield(self)
      end
      self
    end

    def redis
      @redis ||= Redis.new
    end

    def base_url(url)
      unless url =~ /\/$/
        url << '/'
      end
      @base_url  = url
      #@base_url = url.sub(//)
    end

    def generate(url, options={})
      @type = @type || options[:type] || ''
      case @type.to_sym
      when :random
        url_for_random(url)
      else
        url_for_md5(url)
      end
    end

    def get_url(key)
      redis.get key
    end

    def url_for_md5(url)
      url        = decorate_url(url)
      hex        = md5(url)
      short_urls = []
      for i in (0..3)
        hex_int  = 0x3FFFFFFF & hex[i*8, 8 ].to_i(16)
        short_url = ''
        for j in (0..5)
          index     = 0x0000003D & hex_int
          short_url  << URL_CHARS[index ]
          hex_int   =  hex_int >> 5
        end
        unless redis.exists short_url
          redis.set(short_url,url)
          return short_url
        end
        short_urls << short_url
      end
      short_urls.each do |short_url|
        if redis.get(short_url)  == url
          return short_url
        end
      end
      raise UrlError, "generate failed,change other url"
    end

    def url_for_random(url, max_rand)
      url = decorate_url(url)
      (max_rand || @max_rand || MAX_RAND).times{
        out_char = ''
        6.times{
          out_char << URL_CHARS[rand(URL_CHARS_SIZE) ]
        }
        unless redis.exists out_char
          redis.set(out_char,url)
          return out_char
        end
      }
      raise UrlError, "generate failed,change again"
    end

    def decorate_url(url)
      url  = "#{@base_url}#{url}" unless url =~ /^http\:\/\//
      url
    end

    def md5(url)
      Digest::MD5.hexdigest("#{url}#{@token_key}")
    end
  end
end
