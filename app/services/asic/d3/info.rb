require 'open-uri'
require 'nokogiri'

class Asic::D3::Info

  attr_reader :machine

  def initialize(machine)
    @machine = machine
  end

  def info
    begin
      puts "make request on #{machine.ip}"
      body = RestClient.get(info_url, headers).body
      html = Nokogiri::HTML(body)
      puts "html parsed request on #{machine.ip}"
      parse_html(html)
    rescue Exception => e
      puts "fail request on #{machine.ip}"
      puts "error #{e}"
      nil
    end
  end

  def info_url
    p 'get info url'
    "#{machine.url}/cgi-bin/minerStatus.cgi"
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
      success: check_success(html),
      temparatures: get_temp(html),
      active: true
    }
  end

  def get_temp(html)
    html.css('#cbi-table-1-temp2').map do |d|
      d.children.first.to_s.split(':').last
    end
  end

  def check_success(html)
    has_x = html.css('#cbi-table-1-status').map do |d|
      d.children.first.to_s
    end.join('').include?('x')
    !has_x
  end

end
