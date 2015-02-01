require "bundler/gem_tasks"
require "rake/testtask"
require "rdoc/task"

task default: :test

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = FileList["test/**/*_test.rb"]
  test.verbose = true
end

Rake::RDocTask.new(rdoc: "doc", clobber_rdoc: "doc:clean", rerdoc: "doc:force") do |rdoc|
  rdoc.main = "README.md"
  rdoc.title = "Dorans API Documentation"
  rdoc.options << "--line-numbers"
  rdoc.rdoc_files.include("README.md", "lib/**/*.rb")
  rdoc.rdoc_dir = "doc"
end
