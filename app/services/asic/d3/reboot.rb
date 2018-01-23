class Asic::D3::Reboot
  attr_reader :reboot

  def self.call(*args)
    new(*args).call
  end

  def initialize(machine)
    @machine = machine
  end

  def call

  end
end
