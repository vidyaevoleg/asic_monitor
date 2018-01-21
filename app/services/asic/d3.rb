class Asic::D3 < Asic

  def info_url
    "#{machine.url}/cgi-bin/minerStatus.cgi"
  end
end
