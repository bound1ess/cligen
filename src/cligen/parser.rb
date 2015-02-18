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

            lines = @src.lines.map do |line|
                line.delete($/)
            end

            lines.select! do |line|
                not line.empty?
            end

            lines.each_with_index do |line, pos|
                if not (block = try_to_match(line)).nil?
                    if block["value"].empty?
                        lines[(pos + 1)..-1].each do |line|
                            if try_to_match(line).nil?
                                block["value"] += line + "<br>"
                            else
                                break
                            end
                        end
                    end

                    blocks.push(block)
                end
            end

            @blocks = blocks
        end

        # Attempts to convert given string into a code/plaintext/section block.
        # On success returns a block (Hash), otherwise nil.
        def try_to_match(line)
            if not (match = line.match(/^\/\/\s=section:(.+)$/)).nil?
                # That's a section.
                return {
                    "type" => "section",
                    "value" => match.captures.first.gsub(/\"/, "")
                }
            end

            if not (match = line.match(/^\/\/\s=code:(\w+)$/)).nil?
                # That's a code snippet.
                return {
                    "type" => "code",
                    "lang" => match.captures.first,
                    "value" => ""
                }
            end

            if not (match = line.match(/^\/\/\s=text$/)).nil?
                # That's a plain text.
                return {
                    "type" => "plaintext",
                    "value" => ""
                }
            end

            nil
        end
    end
end
