job_type :rake, "cd :path && rake :task --silent"
every 5.minutes do
  rake "stats:fetch"
end
