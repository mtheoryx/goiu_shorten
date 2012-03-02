require 'savon'

module GoiuShorten
  class GoiuShortenApi
    def initialize
      @client = Savon::Client.new do
        wsdl.document = 'https://go.iu.edu/GoIUWebService.asmx?WSDL'
      end
    end

    def expand(*short_url)

      if short_url.nil?
        raise ArgumentError
      end

      api_response = @client.request :decode do
        soap.body = {'tinyURL' => short_url}
      end
      result = api_response.to_hash[:decode_response][:decode_result]
      result
    end


    def shorten(long_url, passcode)
      #Going to check the argument order here
      unless (long_url =~ /^[a-z]{2,5}:\/\//)
        raise ArgumentError
        exit
      end

      unless passcode =~ /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/
        raise ArgumentError, "You must supply a passcode to shorten URLs."
        exit
      end

      api_response = @client.request :encode do
        soap.body = {'passCode' => passcode, 'longURL' => long_url}
      end

      result = api_response.to_hash[:encode_response][:encode_result]

      if (result =~ /^\*\*ERR\*\*\sPasscode/)
        raise ArgumentError, "Not a valid passcode."
      end

      result
    end
  end


end