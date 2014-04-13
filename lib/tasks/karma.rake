desc "Run karma runner for unit/integrations tests"
task :karma do
  sh "karma start jsspec/config_unit.coffee"
end
