class Asic
  attr_reader :machine

  def initialize(machine)
    @machine = machine
  end

  def update_config
    Machines::UpdateAsic.run(machine: machine)
  end

  def status

  end

  def info
    @info ||= machine.remote.class.const_get('Info').get(info_url)
  end

  def info_url
    '/'
  end

end
