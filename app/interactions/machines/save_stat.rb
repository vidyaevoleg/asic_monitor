module Machines
  class SaveStat < ::ApplicationInteraction
    attr_reader :remote, :info, :stat
    object :machine, class: Machine

    def execute
      @remote = Asic[machine]
      @info = remote.info
      if info
        @stat = save_actual_stat
      else
        @stat = machine.stats.create(Stat::INVALID)
      end
      machine.update(stat_id: stat.id)
    end

    private

    def save_actual_stat
      last_actual_stat = machine.stats.order(id: :asc).where(success: true).last
      if last_actual_stat && last_actual_stat&.blocks.to_i > 0 && info[:blocks] == "0"
        machine.update(blocks_count: machine.blocks_count.to_i + 1)
      end
      stat = machine.stats.create(info)
      StatAnalyzer.call(stat)
      stat
    end

  end
end
