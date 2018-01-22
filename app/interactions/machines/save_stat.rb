module Machines
  class SaveStat < ::ApplicationInteraction
    attr_reader :remote, :info
    object :machine, class: Machine

    def execute
      @remote = Asic[machine]
      @info = remote.info
      if info
        save_actual_stat
      else
        machine.stats.create(Stat::INVALID)
      end
    end

    private

    def save_actual_stat
      last_actual_stat = machine.stats.order(id: :asc).where(success: true).last
      if last_actual_stat && last_actual_stat&.blocks.to_i > 0 && info[:blocks] == "0"
        machine.update(blocks_count: machine.blocks_count.to_i + 1)
      end
      machine.stats.create(info)
    end

  end
end
