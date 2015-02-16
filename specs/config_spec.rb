require_relative "../src/cligen/config"

RSpec.describe(Cligen::Config) do
    it("loads configuration") do
        config = Cligen::Config.new

        expect(config.load("invalid path")).to eq(nil)
        expect(config.load(FIXTURES_DIR + "/cligen.yml")).to be_a(Hash)
    end
end
