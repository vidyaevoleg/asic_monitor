class Asic::Base::Reboot
  attr_reader :machine

  def self.call(*args)
    new(*args).call
  end

  def initialize(machine)
    @machine = machine
  end

  def call
    RestClient.get(reboot_url, headers) do |req, res|
      if req.code == 500
        return true
      else
        raise "Machine #{machine.ip} didn't respond"
      end
    end
  end

  def reboot_url
    "#{machine.url}/cgi-bin/reboot.cgi?_=1515606112793"
  end

  def headers
    {
      'Authorization': 'Digest username="root", realm="antMiner Configuration", nonce="99555087629fb07166425ba8fc60c615", uri="/cgi-bin/reboot.cgi?_=1515606112793", response="d189f7d7a1fa850dfa5b51d04aee2b51", qop=auth, nc=000000d9, cnonce="d7a55d911601b746"'
    }
  end
end
