desc "Run karma test runner for JavaScript tests"
task :karma do
  sh "karma start jsspec/config.coffee"
end