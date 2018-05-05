class Asic::DM22::Update < Asic::Base::Update
  attr_reader :machine, :template, :cookies, :pools_count

  def self.call(*args)
    new(*args).call
  end

  def initialize(machine)
    @machine = machine
    @template = machine.template
    login
    get_pools_count
  end

  def call
    add_pool
    top_pool
    save_config
  end

  def add_pool
    body = {
      selpool: 0,
      url: template.public_send("url1"),
      user: template.public_send("worker1"),
      pass:template.public_send("password1"),
      ipport: machine.url.gsub('http://', ''),
      warntemp: 45,
      safetemp: 38,
      addpool: 'Add+Pool',
      emailserver: nil,
      emailuser: nil,
      emailpass: nil,
      email: nil,
      timezone: 8,
      netmask: '255.255.0.0',
      gateway: '192.168.1.1',
      staticipchk: 'staticip',
      globalpll: 380
    }
    req = RestClient.post(update_url, body, headers(body))
  end

  def top_pool
    body = {toppool: pools_count}
    req = RestClient.post(update_url, body, headers(body))
  end

  def save_config
    body = {saveconf: 'Save+Configuration'}
    req = RestClient.post(update_url, body, headers(body))
  end

  def login
    @cookies = Asic::DM22::Login.call(machine)
  end

  def headers(body={})
    cookie = "PHPSESSID=#{cookies['PHPSESSID']}"
    {
      'Cookie' => cookie,
      'Host' => machine.url.gsub('http://', ''),
      'Content-Length' => body.to_query.length,
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Referer' => update_url
    }
  end

  def get_pools_count
    req = RestClient.get(update_url, get_headers)
    html = Nokogiri::HTML(req.body)
    @pools_count = html.css('.acuity')[2].children.count - 3
  end

  def get_headers
    cookie = "PHPSESSID=#{cookies['PHPSESSID']}"
    {
      'Cookie' => cookie,
      'Host' => machine.url.gsub('http://', ''),
      'Referer' => update_url
    }
  end

  def update_url
    "#{machine.url}/edithost.php?id=1"
  end
end
