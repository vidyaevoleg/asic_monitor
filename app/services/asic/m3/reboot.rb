class Asic::M3::Reboot
  attr_reader :machine, :cookies, :token

  def self.call(*args)
    new(*args).call
  end

  def initialize(machine)
    @machine = machine
    get_token
  end

  def call
    output = Kernel.system(command)
    if output == true
      true
    else
      raise "Machine #{machine.ip} didn't respond"
    end
  end

  def command
    "curl -b 'sysauth=#{cookies['sysauth']}' -F token=#{token} #{reboot_post_url}"
  end

  def get_token
    req = RestClient.get(reboot_url)
    @cookies = req.cookies
    @token = req.body.split("{ token: '").last.first(32)
  end

  def reboot_url
    "#{machine.url}/cgi-bin/luci/admin/system/reboot?luci_username=root&luci_password=root"
  end

  def reboot_post_url
    "#{machine.url}/cgi-bin/luci//admin/system/reboot/call?luci_username=root&luci_password=root"
  end
end
