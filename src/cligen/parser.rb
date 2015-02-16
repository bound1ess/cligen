module Cligen
    # This class is responsible for parsing .cligen files.
    class Parser
        def initialize(file)
            if not File.exist?(file)
                raise RuntimeError, "File #{file} doesn't exist."
            end

            @src = File.read(file)
            @sections = nil
            @blocks = nil
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

        # Returns all text blocks described in the file (both "plaintext" and "code" blocks).
        # An example of output: [{"type" => "code", "value" => "some code", "lang" => "php"}]
        def get_text_blocks
            if not @blocks.nil?
                return @blocks
            end

            blocks = Array.new

            # @todo

            @blocks = blocks
        end
    end
end
