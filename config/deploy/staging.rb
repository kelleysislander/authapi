#############################################################
#	Application
#############################################################

set :application, "AuthAPI"
set :deploy_to, "/var/www/vhosts/authapi.semaphoremobile.com"
set :app_full_name, "authapi.semaphoremobile.com"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :chmod755, "app config db lib public vendor script script/* public/*"
ssh_options[:forward_agent] = true
ssh_options[:port] = 922
set :use_sudo, true
set :scm_verbose, true
set :rails_env, "staging"

#############################################################
#	Servers
#############################################################

print "Input user: "
user = STDIN.gets.chomp
set :user, user
set :domain, "semastage"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	hg
#############################################################

set :scm, :mercurial
set :deploy_via, :checkout
#set :checkout, "export"
set :scm_user, user
set :repository, "ssh://sematrac//home/code.hg/authapi.semaphoremobile.com"

#############################################################
#	Passenger
#############################################################

namespace :deploy do
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
