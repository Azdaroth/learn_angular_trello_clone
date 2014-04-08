# based on https://github.com/TalkingQuickly/capistrano-3-rails-template
set :application, "trello_clone"
set :deploy_user, 'deploy'

set :pty, true
set :use_sudo, false

set :ssh_options, {
  forward_agent: true
}

set :default_env, { rvm_bin_path: '/usr/local/rvm/bin/rvm' }
SSHKit.config.command_map[:rake] = "bundle exec rake"
set :default_shell, '/bin/bash --login'

# setup repo details
set :scm, :git
set :repo_url, "url"

# setup rvm.
set :rvm_type, :system
set :rvm_ruby_version, 2.1.0

# how many old releases do we want to keep, not much
set :keep_releases, 5

# files we want symlinking to specific entries in shared
set :linked_files, %w{config/database.yml config/application.yml}

# dirs we want symlinking to shared
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, ["spec"]

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  database.example.yml
  application.example.yml
  log_rotation
))


namespace :deploy do
  before :deploy, "deploy:check_revision"
  before :deploy, "deploy:run_tests"
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'
end

