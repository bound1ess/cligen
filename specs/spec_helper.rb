require "simplecov"

FIXTURES_DIR = File.dirname(__FILE__) + "/../fixtures"

SimpleCov.start do
    add_filter "/specs/"
end
