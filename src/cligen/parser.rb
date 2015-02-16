module Cligen
    # This class is responsible for parsing .cligen files.
    class Parser
        def initialize(file)
            if not File.exist?(file)
                raise RuntimeError, "File #{file} doesn't exist."
            end

            @src = File.read(file)
            @sections = nil
        end

        # Returns all sections (as a Hash) described in the file.
        # An example of output: { "Doing s0m3th1ng @#$" => "#doing-s0m3th1ng" }
        def get_sections
            if not @sections.nil?
                return @sections
            end

            sections = Hash.new

            @src.scan(/^\/\/\s=section:(.+)$/).each do |match|
                name, hashtag = match.first.clone, match.first

                hashtag.gsub!(/\s/, "-")
                hashtag.gsub!(/[^a-zA-Z0-9\-]+/, "")

                sections[name.gsub(/\"+/, "")] = "#" + hashtag.downcase
            end

            @sections = sections
        end
    end
end
