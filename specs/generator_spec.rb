require_relative "../src/cligen/generator"

RSpec.describe(Cligen::Generator) do
    it("generates a page") do
        generator = Cligen::Generator.new
        data = {
            "message" => "Hello"
        }

        expect(generator.generate_page(FIXTURES_DIR + "/template.erb", data)).to eq("Hello\n")
    end
end
