namespace :sidekiq_graceful_shutdown do
  desc 'prepare shutdown'
  task prepare_shutdown: :environment do
    SidekiqGracefulShutdown::Sidekiq.prepare_shutdown
  end

  desc 'shutdown'
  task shutdown: :environment do
    SidekiqGracefulShutdown::Sidekiq.shutdown
  end
end
