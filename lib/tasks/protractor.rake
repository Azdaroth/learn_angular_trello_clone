desc "Run acceptance tests"
task :js_acceptance do
  # make sute this has been run: 
  sh "protractor jsspec/protractor_conf.js"
end