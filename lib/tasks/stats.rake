namespace :stats do
  task fetch: [:environment] do
    Machine.find_each do |machine|
      StatJob.perform_now(machine.id)
      puts "machine #{machine.id}"
      sleep 2
    end
  end
end
