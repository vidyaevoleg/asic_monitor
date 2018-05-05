class Asic::DM22::Reboot < Asic::Base::Reboot
  attr_reader :machine, :cookies

  def self.call(*args)
    new(*args).call
  end

  def initialize(machine)
    @machine = machine
    login
  end

  def call
    RestClient.post(reboot_url, body, headers)
  end

  def login
    @cookies = Asic::DM22::Login.call(machine)
  end

  def reboot_url
    "#{machine.url}/restart.php"
  end

  def headers
    cookie = "PHPSESSID=#{cookies['PHPSESSID']}"
    {
      'Cookie' => cookie,
      'Host' => machine.url.gsub('http://', ''),
      'Content-Length' => body.to_query.length,
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Referer' => reboot_url
    }
  end

  def body
    {
      host: 'iBeLink'
    }
  end
end
