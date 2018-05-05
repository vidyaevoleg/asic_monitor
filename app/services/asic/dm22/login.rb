class Asic::DM22::Login
  attr_reader :machine
  def self.call(*args)
    new(*args).call
  end

  def initialize(machine)
    @machine = machine
  end

  def call
    begin
      RestClient.post(login_url, body, headers)
    rescue RestClient::ExceptionWithResponse => e
      e.response.cookies
    end
  end

  def login_url
    "#{machine.url}/login.php"
  end

  def body
    {
      username: "iBeLink",
      password: "iBeLink",
      submit: 'Login'
    }
  end

  def headers
    {
      'Host' => machine.url.gsub('http://', ''),
      'Content-Length' => body.to_query.length,
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Referer' => login_url
    }
  end
end
