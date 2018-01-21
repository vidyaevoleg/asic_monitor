require 'open-uri'
require 'nokogiri'
class Asic::D3::Info

  class << self
    def get(url)
      begin
        body = RestClient.get(url, headers).body
        html = Nokogiri::HTML(body)
        parse_html(html)
      rescue
        nil
      end
    end

    def headers
      {
        'Authorization': 'Digest username="root", realm="antMiner Configuration", nonce="99555087629fb07166425ba8fc60c615", uri="/cgi-bin/minerStatus.cgi", response="1ba539812f50b3a05b853ab6b1e6e306", qop=auth, nc=00000364, cnonce="da189beb789c629b"'
      }
    end

    def parse_html(html)
      {
        blocks: html.css('#ant_foundblocks').children.first.to_s,
        hashrate: html.css('#ant_ghsav').children.first.to_s,
        valid: get_valid(html),
        temparatures: get_temp(html)
      }
    end

    def get_temp(html)
      html.css('#cbi-table-1-temp2').map do |d|
        d.children.first.to_s.split(':').last
      end
    end

    def get_valid(html)
      has_x = html.css('#cbi-table-1-status').map do |d|
        d.children.first.to_s
      end.join('').include?('x')
      !has_x
    end
  end
end
