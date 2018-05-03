class Asic::A3::Update < Asic::Base::Update
  def headers
    {
      'Authorization' => 'Digest username="root", realm="antMiner Configuration", nonce="2a8296c9cd1fcd947b2252500641355a", uri="/cgi-bin/set_miner_conf.cgi", response="1a7be41b396e067046bb5d6b12554298", qop=auth, nc=00000084, cnonce="87275d9b918c95b3"',
    }
  end
end
