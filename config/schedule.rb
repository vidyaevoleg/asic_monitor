job_type :rake, "cd :path && rake :task --silent :output"

every 5.minutes do
  rake "stats:fetch", output: { standard: 'log/stats.log' }
end

every 1.day, at: '4:30 am' do
  rake "stats:clear", output: { standard: 'log/stats.log' }
end
