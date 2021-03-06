module Cligen
    require "optparse"

    # Command Line Interface (CLI).
    # This class manages everything related.
    class Cli
        attr_reader :config

        def initialize
            @config = Dir.getwd + "/cligen.yml"
        end

        # This method initializes and configures OptionParser.
        # Returns a new instance of OptionParser.
        def setup
            OptionParser.new do |options|
                options.banner = "Usage: cligen generate [options]"

                options.on("-h", "--help", "Prints help message") do
                    puts options
                    exit
                end

                options.on("-c=PATH", "--config=PATH", "Config file to use") do |config|
                    if not config.start_with?("/")
                        config = File.join(Dir.getwd, config)
                    end

                    @config = config
                end
            end
        end

        # Executes given OptionParser instance with given ARGV value.
        # Returns nothing (void), may exit.
        def execute!(parser, argv)
            if not argv.empty?
                begin
                    parser.parse!(argv)
                rescue OptionParser::ParseError
                    puts $!.to_s
                    exit
                end
            end
        end
    end
end
