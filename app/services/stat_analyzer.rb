class StatAnalyzer
  attr_reader :previous, :stat, :machine, :asic

  def self.call(*args)
    new(*args).call
  end

  def initialize(stat)
    @stat = stat
    @machine = stat.machine
    @asic = Asic[machine]
    @previous = machine.stats.order(id: :desc).where.not(id: stat.id).limit(5)
  end

  def call
    need_reboot = false
    begin
      if hashrate_down?
        Notifier.hashrate_down(machine)
      end
      if unsuccessfull?
        need_reboot = true
      end
      if temp_up?
        Notifier.temp_up(machine)
        need_reboot = true
      end
      if shut_down?
        Notifier.shut_down(machine)
      end
    ensure
      asic.reboot if need_reboot
    end
  end

  private

  def hashrate_down?
    asic.hashrate.to_f - stat.hashrate.to_f > asic.delta * asic.hashrate.to_f
  end

  def temp_up?
    stat.temparatures.map(&:to_f).max.to_i > asic.max_temp
  end

  def unsuccessfull?
    return false if previous.size < 5
    unsuc_via_period = previous.first.success && !(previous - previous.first).last(4).map(&:success).include?(true)
    unsuc_via_period && !stat.success
  end

  def shut_down?
    return false if previous.size < 5
    shut_down_via_period = previous.first.active && !(previous - previous.first).last(4).map(&:active).include?(true)
    shut_down_via_period && !stat.active
  end
end
