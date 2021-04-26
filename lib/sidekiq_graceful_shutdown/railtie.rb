class SidekiqGracefulShutdown::Railtie < ::Rails::Railtie
  rake_tasks do
    Dir[File.expand_path("railtie/**/*.rake", File.dirname(__FILE__))].each do |file|
      load file
    end
  end
end
