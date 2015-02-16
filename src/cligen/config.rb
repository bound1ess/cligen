module Cligen
    require "yaml"

    # This class manages Cligen configuration.
    class Config
        # Attempts to load configuration from cligen.yml file.
        # Receives a fully qualified path to the current working directory (as a string).
        # Returns nil on failure, otherwise Hash.
        def load(path)
            if not path.include? "cligen.yml"
                path = File.join(path, "cligen.yml")
            end

            if not File.exist?(path)
                return nil
            end

            YAML.load(File.read(path))
        end

        # Transforms configuration to a format that's easy to work with inside of the app.
        # Expects configuration (as a Hash object) to be passed.
        # Returns Hash as well.
        def transform(config)
            new_config = {
                "main" => {}
            }

            config["main"].each do |key, value|
                if not value.start_with?("@")
                    new_config["main"][key] = value
                    next
                end

                new_config["main"][key] = config[value[1..-1]]

                new_config["main"][key].each do |sub_key, value|
                    new_config["main"][key][sub_key] = File.join(Dir.getwd, value)
                end
            end

            new_config
        end
    end
end
