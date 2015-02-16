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
    end
end
