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

            @page_template = File.dirname(__FILE__) + "/../../templates/page.erb"
            @main_template = File.dirname(__FILE__) + "/../../templates/main.erb"
        end

        # Runs Cligen with given ARGV value.
        def run(argv)
            # Find out path to the config file.
            @cli.execute!(@cli.setup, ARGV)
            config = @cli.config

            puts "Using #{config} configuration file..."

            # Try to load it.
            if (config = @config.load(config)).nil?
                puts "Configuration file doesn't exist."
                exit
            end

            # Transform it.
            config = @config.transform(config)

            print "The following pages are about to be built: "

            pages = Array.new
            config["main"].map do |key, value|
                if value.is_a?(Hash)
                    pages.push(key)
                end
            end

            puts pages.join(", ") + "."

            # Parse all configuration files.
            pages_config = Hash.new

            pages.each do |page|
                pages_config[page] = config["main"][page]
                pages_config[page]["from"] = Cligen::Parser.new(pages_config[page]["from"])
            end

            # Saving pages.
            pages_config.each do |page, config|
                data = {
                    "title"    => page,
                    "sections" => config["from"].get_sections,
                    "blocks"   => config["from"].get_text_blocks
                }

                File.write(config["to"], @generator.generate_page(@page_template, data))
            end

            # Generate and save main.html.
            puts "Generating main page..."

            pages.map! do |page|
                pages_config[page]["to"].split("/").last
            end

            main_title = Dir.getwd.split("/").last

            data = {
                "title" => main_title,
                "pages" => pages
            }

            File.write(
                File.join(Dir.getwd.include?("cligen") ? "builds" : Dir.getwd, "main.html"),
                @generator.generate_page(@main_template, data)
            )

            puts "Done."
        end
    end
end
