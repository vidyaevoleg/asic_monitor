module Machines
  class Create < ::ApplicationInteraction
    attr_reader :machine

    string :model
    string :serial, default: nil
    string :place
    string :ip, default: nil

    validate do
      unless Machine.models.keys.include?(model)
        errors.add(:model, :invalid)
      end
    end

    def execute
      @machine = Machine.create(inputs.merge(ip: ip.present? ? ip : next_ip))
      errors.merge!(machine.errors)
      if valid?
        template = Template.create(settings.merge(machine: machine))
      end
      self
    end

    def to_model
      machine.reload
    end

    private

    def settings
      @pool ||= pools.find do |pool|
        pool[:miners].include?(model)
      end
      @pool[:settings] rescue {}
    end

    def pools
      @pools ||= PoolConfig.all
    end

    def next_ip
      @next_ip ||= begin
        last_ip = Machine.order(id: :desc).first.try(:ip) || Machine::START_IP
        last_num = last_ip.split('.').last.to_i
        next_ip = if last_num + 1 < 254
          last_ip.split('.').first(3).push(last_num+1).join('.')
        else
         before_last_num = last_ip.split('.').last(2).first.to_i
         last_ip.split('.').first(2).push(before_last_num + 1).push(1).join('.')
        end
      end
    end
  end
end
