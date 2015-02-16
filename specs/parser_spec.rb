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
end
