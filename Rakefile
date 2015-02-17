task :default => [:test]

task :test do
    sh "rspec ./specs/ --color --format documentation --require ./specs/spec_helper.rb"
end

task :server do
    sh "thin start --port 8000 --address 127.0.0.1 --adapter file"
end

task :build do
    sh "touch cligen-*.gem"
    sh "rm cligen-*.gem"
    sh "gem build cligen.gemspec"
end

task "install-gem" do
    sh "gem install --local cligen-`cat ./version`.gem"
end

task :install do
    sh "bundle"
end

task "builds-dir" do
    sh "mkdir builds/"
end
