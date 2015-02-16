require_relative "../src/cligen/generator"

RSpec.describe(Cligen::Generator) do
    it("generates a page") do
        generator = Cligen::Generator.new

        expect(generator.generate_page(FIXTURES_DIR + "/template.erb", {})).to be_a(String)
    end
end
