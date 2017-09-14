job_type :rake,    "cd :path && bundle exec rake :task :output"

every 5.minutes do
  rake "news:get_yandex_news"
end
