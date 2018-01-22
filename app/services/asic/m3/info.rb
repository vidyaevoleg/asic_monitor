require 'open-uri'
require 'nokogiri'
class Asic::M3::Info
  attr_reader :machine, :html

  def initialize(machine)
    @machine = machine
  end

  def info
    begin
      body = RestClient.get(info_url).body
      @html = Nokogiri::HTML(body)
      parse_html
    rescue Exception => e
      nil
    end
  end

  def info_url
    "#{machine.url}/cgi-bin/luci/admin/status/cgminerstatus?luci_username=root&luci_password=root"
  end

  def parse_html
    {
      blocks: get_blocks,
      hashrate: get_hashrate,
      success: check_success,
      temparatures: get_temp,
      active: true
    }
  end

  def get_hashrate
    html.css('#cbi-table-1-mhsav').children.first.to_s.strip.to_i
  end

  def get_blocks
    0
  end

  def get_temp
    (1..3).to_a.map do |i|
      html.css("#cbi-table-#{i}-temp_1").children.first.to_s.strip.to_i
    end
  end

  def check_success
    statuses = (1..3).to_a.map do |i|
      html.css("#cbi-table-#{i}-status").children.first.to_s.strip == "Alive"
    end
    !statuses.include?(false)
  end
end
