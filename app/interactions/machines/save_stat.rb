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
      last_actual_stat = machine.stats.order(id: :desc).where(success: true).limit(1).first
      if info[:blocks].to_i > last_actual_stat&.blocks.to_i
        # we found new block
        diff = info[:blocks].to_i - last_actual_stat.blocks
        machine.update(blocks_count: machine.blocks_count + diff)
      end
      stat = machine.stats.create(info)
      StatAnalyzer.call(stat)
      stat
    end

  end
end
