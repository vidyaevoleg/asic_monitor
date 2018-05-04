class Asic::A3::Info < Asic::Base::Info
  def info_url
    "#{machine.url}/cgi-bin/get_status_api.cgi"
  end

  def headers
    {
      'Authorization': 'Digest username="root", realm="antMiner Configuration", nonce="2a8296c9cd1fcd947b2252500641355a", uri="/cgi-bin/get_system_info.cgi?_=1525360659466", response="9d4daf89d109b9e50d833384a95b8b98", qop=auth, nc=00000102, cnonce="3cd8a0ad69bd5be9"'
    }
  end

  def parse_stat_html
    {
      blocks: data["Found Blocks"].to_i,
      hashrate: data.dig("GHS 5s").to_f,
      success: check_success,
      temparatures: get_temp,
      active: true
    }
  end

  def get_temp
    [data["temp1"], data["temp2"], data["temp3"]].map(&:to_f)
  end

  def check_success
    words = [data["chain_acs1"], data["chain_acs2"], data["chain_acs3"]].join('')
    (words.count('x').to_f / (words.count('o').to_f + words.count('x').to_f))  < 0.1
  end

  def data
    @data ||= begin
      text = html.children.last.children.first.children.first.children.first.text.split(',')
      answer = {}
      text.each {|o| key = o.split('=')[0]; value=o.split('=')[1]; answer[key]=value}
      answer
    rescue
      {}
    end
  end

end
