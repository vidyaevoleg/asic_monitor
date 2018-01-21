namespace :stats do
  task fetch: [:environment] do
    Machine.find_each do |machine|
      machine.save_stat
    end
  end
end
