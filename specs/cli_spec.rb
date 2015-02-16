require_relative "../src/cligen/cli"

RSpec.describe(Cligen::Cli) do
    it("configures OptionParser") do
        cli = Cligen::Cli.new

        expect(cli.setup).to be_an(OptionParser)
    end

    it("executes OptionParser instance") do
        cli = Cligen::Cli.new

        # Reset the arguments list.
        level = $VERBOSE
        $VERBOSE = nil

        ARGV = Array.new

        $VERBOSE = level

        # "Fake" stdout.
        orig_stdout = $stdout
        $stdout = FakeStdout.new

        begin
            cli.execute!(cli.setup)
        rescue SystemExit # => error
            # puts error.to_s
        end

        ARGV.push("--config=foo")
        cli.execute!(cli.setup)

        begin
            ARGV.push("--invalid-option")
            cli.execute!(cli.setup)
        rescue SystemExit
            # ...
        end

        # Switch to "normal" stdout.
        $stdout = orig_stdout
    end
end

class FakeStdout
    def write(something)
        # Do nothing.
    end
end
