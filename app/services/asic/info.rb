class Asic::Info
  attr_reader :machine

  def initialize(machine)
    @machine = machine
  end

  def info
    nil
  end

  def info_url
    "#{machine.url}/"
  end
end
