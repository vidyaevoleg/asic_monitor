module Machines
  class Reboot < ::ApplicationInteraction
    object :machine
    string :ip, default: nil
    string :user, default: nil

    def to_model
      machine.reload
    end

    def execute
      begin
        output = Asic[machine].reboot
        machine.machine_logs.create(ip: ip, name: 'reboot', user: user)
      rescue
        errors.add(:machine, "#{machine.ip} didn't respond")
      end
      self
    end
  end
end
