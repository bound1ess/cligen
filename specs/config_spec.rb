require_relative "../src/cligen/config"

RSpec.describe(Cligen::Config) do
    it("loads configuration") do
        config = Cligen::Config.new

        expect(config.load("invalid path")).to eq(nil)
        expect(config.load(FIXTURES_DIR + "/cligen.yml")).to be_a(Hash)
    end

    it("transforms configuration") do
        config = Cligen::Config.new

        expect(config.transform(config.load(FIXTURES_DIR))).to eq({
            "main" => {
                "github" => "https://github.com/bound1ess/essence",
                "packagist" => "https://packagist.org/packages/bound1ess/essence",
                "documentation" => {
                    "from" => "#{Dir.getwd}/docs.cligen",
                    "to" => "#{Dir.getwd}/docs.html"
                }
            }
        })

        expect(config.transform({})).to eq({
            "main" => {}
        })
    end
end
