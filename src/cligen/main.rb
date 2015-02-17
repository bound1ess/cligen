module Cligen
    require_relative "config"
    require_relative "parser"
    require_relative "generator"
    require_relative "cli"

    # This class ties everything together and makes it work.
    class Main
        def initialize
            @cli       = Cligen::Cli.new
           #@parser    = Cligen::Parser.new
            @config    = Cligen::Config.new
            @generator = Cligen::Generator.new
        end

        # Runs Cligen with given ARGV value.
        def run(argv)
            # Find out path to the config file.
            @cli.execute!(@cli.setup, ARGV)
            config = @cli.config

            puts config
        end
    end
end
