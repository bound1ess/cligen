require_relative "../src/cligen/cli"

RSpec.describe(Cligen::Cli) do
    it("configures OptionParser") do
        cli = Cligen::Cli.new

        expect(cli.setup).to be_an(OptionParser)
    end

    it("executes OptionParser instance") do
        cli = Cligen::Cli.new
        argv = Array.new

        # "Fake" stdout.
        orig_stdout = $stdout
        $stdout = FakeStdout.new

        cli.execute!(cli.setup, argv)

        argv.push("--config=foo")
        cli.execute!(cli.setup, argv)

        begin
            argv.push("--help")
            cli.execute!(cli.setup, argv)
        rescue SystemExit
            # ...
        end

        begin
            argv.push("--invalid-option")
            cli.execute!(cli.setup, argv)
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
