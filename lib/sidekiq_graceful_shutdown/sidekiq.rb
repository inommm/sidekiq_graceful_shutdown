module SidekiqGracefulShutdown
  class Sidekiq
    class << self
      def shutdown
        interval_sec = 5.seconds
        hostname     = Socket.gethostname

        quit_processes_by_hostname(hostname)

        loop do
          processes = find_processes_by_hostname(hostname)
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

      def prepare_shutdown
        interval_sec = 5.seconds
        hostname     = Socket.gethostname

        quit_processes_by_hostname(hostname)

        loop do
          processes = find_processes_by_hostname(hostname)
          if processes.all? { |process| process['quiet'] == 'true' && process['busy'] == 0 }
            break
          end

          sleep interval_sec
        end
      end

      def find_processes_by_hostname(hostname)
        ::Sidekiq::ProcessSet.new.to_a.select { |p| p['hostname'] == hostname }
      end

      def quit_processes_by_hostname(hostname)
        find_processes_by_hostname(hostname).each do |process|
          puts "stopping process: pid:#{process['pid']}"
          begin
            Process.kill('TSTP', process['pid'])
          rescue Errno::ESRCH
          end
        end
      end
    end
  end
end
