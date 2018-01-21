namespace :stats do
  task fetch: [:environment] do
    logger           = Logger.new(STDOUT)
    logger.level     = Logger::INFO
    Rails.logger     = logger

    Machine.find_each do |machine|
      StatJob.perform_later(machine.id)
    end
  end
end
