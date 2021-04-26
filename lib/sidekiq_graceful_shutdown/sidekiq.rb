module SidekiqGracefulShutdown
  class Sidekiq
    class << self
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
