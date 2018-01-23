class Asic::M3::Update
  attr_reader :machine, :template, :token, :cookies

  def self.call(*args)
    new(*args).call
  end

  def initialize(machine)
    @machine = machine
    @template = machine.template
    set_token_and_cookies
  end

  def call
    Kernel.system(command)
    Asic[machine].reboot
  end

  def command
    "curl -b 'sysauth=#{cookies['sysauth']}' -F 'token=#{token}'  -F 'cbi.submit=1' -F 'cbi.apply=Save & Apply' -F 'cbid.pools.default.ntp_enable=global' -F 'cbid.pools.default.ntp_pools=' -F 'cbid.pools.default.pool1url=#{template.url1}' -F 'cbid.pools.default.pool1user=#{template.worker1}' -F 'cbid.pools.default.pool1pw=#{template.password1}' -F 'cbid.pools.default.pool2url=#{template.url2}' -F 'cbid.pools.default.pool2user=#{template.worker2}' -F 'cbid.pools.default.pool2pw=#{template.password2}' -F 'cbid.pools.default.pool3url=#{template.url3}' -F 'cbid.pools.default.pool3user=#{template.worker3}' -F 'cbid.pools.default.pool3pw=#{template.password3}' #{update_url}"
  end

  def set_token_and_cookies
    req = RestClient.get(update_url)
    html = Nokogiri::HTML(req.body)
    @token = html.at('input[name=token]').values.last
    @cookies = req.cookies
  end

  def update_url
    "#{machine.url}/cgi-bin/luci/admin/network/cgminer?luci_username=root&luci_password=root"
  end
end
