namespace :stats do
  task fetch: [:environment] do
    logger           = Logger.new(STDOUT)
    logger.level     = Logger::INFO
    Rails.logger     = logger

    Machine.find_each do |machine|
      sleep 1
      StatJob.perform_later(machine.id)
    end
  end
  task clear: [:environment] do
    Stat.where("created_at < ?", 3.days.ago).destroy_all
  end
end
