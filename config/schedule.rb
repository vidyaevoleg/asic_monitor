job_type :rake, "cd :path && rake :task --silent :output"
every 10.minutes do
  rake "stats:fetch", output: { standard: 'log/stats.log' }
end
