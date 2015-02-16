module Cligen
    # This class is responsible for parsing .cligen files.
    class Parser
        def initialize(file)
            if not File.exist?(file)
                raise RuntimeError, "File #{file} doesn't exist."
            end

            @src = File.read(file)
        end
    end
end
