class Asic::D3 < Asic


  def info
    Asic::D3::Info.get(info_url)
  end

  def info_url
    "#{machine.url}/cgi-bin/minerStatus.cgi"
  end
end
