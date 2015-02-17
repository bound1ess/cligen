require_relative "../src/cligen/parser"

RSpec.describe(Cligen::Parser) do
    before(:all) do
        @parser = Cligen::Parser.new(FIXTURES_DIR + "/page.cligen")
    end

    it("raises an exception if invalid file name was supplied") do
        expect { Cligen::Parser.new("invalid file name") }.to raise_error(RuntimeError)
    end

    it("returns all described sections as a hash") do
        sections = {
            "Introduction" => "#introduction",
            "Getting #started" => "#getting-started"
        }

        expect(@parser.get_sections).to eq(sections)
        # Repeated on purpose.
        expect(@parser.get_sections).to eq(sections)
    end

    it("returns all text blocks as an array of hashes") do
        blocks = [
            {
                "type" => "section",
                "value" => "Introduction"
            },
            {
                "type" => "plaintext",
                "value" => "Foobar is the very baz of 123321, false."
            },
            {
                "type" => "code",
                "lang" => "php",
                "value" => "function fac($n) { return ($n <= 1) ? 1 : fac($n - 1); }"
            },
            {
                "type" => "section",
                "value" => "Getting #started"
            },
            {
                "type" => "plaintext",
                "value" => "Whatever it <strong>may be</strong>."
            }
        ]

        expect(@parser.get_text_blocks).to eq(blocks)
        expect(@parser.get_text_blocks).to eq(blocks) # On purpose.
    end
end
