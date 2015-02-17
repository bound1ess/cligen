task :test do
    sh "rspec ./specs/ --color --format documentation --require ./specs/spec_helper.rb"
end

task :server do
    sh "thin start --port 8000 --address 127.0.0.1 --adapter file"
end

task "builds-dir" do
    sh "mkdir builds/"
end
