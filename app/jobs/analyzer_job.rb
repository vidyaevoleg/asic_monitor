class AnalyzerJob < ApplicationJob
  queue_as :default

  def perform(stat_id)
    stat = Stat.find(stat_id)
    StatAnalyzer.call(stat)
  end
end
