require 'nokogiri'

class Asic::DM22::Info < Asic::Base::Reboot
  attr_reader :machine, :html, :cookies

  def initialize(machine)
    @machine = machine
    login
  end

  def info
    begin
      parse_stat_html
    rescue Exception => e
      nil
    end
  end

  def info_url
    "#{machine.url}/index.php"
  end

  def html
    @html ||= begin
      body = RestClient.get(info_url, headers).body
      @html = Nokogiri::HTML(body)
    end
  end

  def headers
    puts cookies
    cookie = "PHPSESSID=#{cookies['PHPSESSID']}"
    {
      'Cookie' => cookie,
      'Host' => machine.url.gsub('http://', ''),
      'Referer' => info_url
    }
  end

  def parse_stat_html
    {
      blocks: 0,
      hashrate: (html.css('td')[13].children.first.to_s.to_f rescue 0),
      success: check_success,
      temparatures: get_temp,
      active: true
    }
  end

  def login
    @cookies = Asic::DM22::Login.call(machine)
  end

  def get_temp
    html.css('td')[10].children.first(8).map(&:to_s).reject {|e| e == "<br>"}.map do |t|
      t.split('C')
    end.flatten.map {|t| t.split(':').last}.map(&:to_i)
  end

  def check_success
    true
  end
end
