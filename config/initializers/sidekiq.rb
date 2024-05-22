Sidekiq.configure_server do |config|
      config.redis = { url: ENV['REDIS_URL'] }
      
      # Load schedule from the schedule.yml file
      schedule_file = "config/schedule.yml"
      if File.exist?(schedule_file) && Sidekiq.server?
            Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
      end
end
    
Sidekiq.configure_client do |config|
      config.redis = { url: ENV['REDIS_URL'] }
end
    