namespace :stats do
  task fetch: [:environment] do
    logger           = Logger.new(STDOUT)
    logger.level     = Logger::INFO
    Rails.logger     = logger

    Machine.find_each do |machine|
      machine.save_stat
    end
  end
end
