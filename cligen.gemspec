Gem::Specification.new do |spec|
    spec.name = "cligen"
    spec.version = File.read(File.dirname(__FILE__) + "/version")
    spec.date = Time.new.strftime("%Y-%m-%d")
    spec.license = "MIT"
    spec.summary = "Deadly simple page generator"
    spec.description = "My experimental project"
    spec.authors = ["bound1ess"]
    spec.email = "bound1ess.dev@gmail.com"
    spec.homepage = "https://github.com/bound1ess/cligen"

    spec.required_ruby_version = ">= 2.0.0"
    spec.executables = ["cligen"]

    spec.add_development_dependency("rspec")
    spec.add_development_dependency("simplecov")
    spec.add_development_dependency("thin")

    spec.files = Dir["src/cligen/*.rb"] + Dir["bin/*"] + Dir["templates/*.erb"]
    spec.test_files = Dir["specs/*.rb"] + Dir["fixtures/*"]
end
