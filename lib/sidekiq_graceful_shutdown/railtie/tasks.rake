namespace :sidekiq_graceful_shutdown do
  desc 'prepare'
  task prepare: :environment do
    interval_sec = 5.seconds
    hostname     = Socket.gethostname

    SidekiqGracefulShutdown::Sidekiq.quit_processes_by_hostname(hostname)

    loop do
      processes = SidekiqGracefulShutdown::Sidekiq.find_processes_by_hostname(hostname)
      if processes.all? { |process| process['quiet'] == 'true' && process['busy'] == 0 }
        break
      end

      sleep interval_sec
    end
  end

  desc 'shutdown'
  task shutdown: :environment do
    interval_sec = 5.seconds
    hostname     = Socket.gethostname

    SidekiqGracefulShutdown::Sidekiq.quit_processes_by_hostname(hostname)

    loop do
      processes = SidekiqGracefulShutdown::Sidekiq.find_processes_by_hostname(hostname)
      if processes.all? { |process| process['quiet'] == 'true' && process['busy'] == 0 }
        processes.each do |process|
          begin
            Process.kill('TERM', process['pid'])
          rescue Errno::ESRCH
          end
        end

        break
      end

      sleep interval_sec
    end
  end
end
