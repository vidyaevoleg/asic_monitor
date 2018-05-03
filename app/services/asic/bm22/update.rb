class Asic::DM22::Update < Asic::Base::Update
  def headers
    {
      'Authorization' => 'Digest username="root", realm="antMiner Configuration", nonce="2a8296c9cd1fcd947b2252500641355a", uri="/cgi-bin/get_system_info.cgi?_=1525360659466", response="9d4daf89d109b9e50d833384a95b8b98", qop=auth, nc=00000102, cnonce="3cd8a0ad69bd5be9"',
    }
  end
end
