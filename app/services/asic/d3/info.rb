class Asic::D3::Info < Asic::D3

  class << self
    def get(url)
      begin
        body = RestClient.get(url, headers).body
        byebug
      rescue
        nil
      end
    end

    def headers
      {
        'Authorization': 'Digest username="root", realm="antMiner Configuration", nonce="99555087629fb07166425ba8fc60c615", uri="/cgi-bin/minerStatus.cgi", response="1ba539812f50b3a05b853ab6b1e6e306", qop=auth, nc=00000364, cnonce="da189beb789c629b"'
      }
    end

  end
end
