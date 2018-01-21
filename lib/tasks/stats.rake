namespace :stats do
  task fetch: [:environment] do
    Machine.find_each do |machine|
      StatJob.perform_now(machine.id)
    end
  end
end
