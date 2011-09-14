#############################################################
#	Application
#############################################################

set :application, "myGroceryMaster"
set :deploy_to, "/var/www/vhosts/admin.mygrocerymaster.com"
set :app_full_name, "admin.mygrocerymaster.com"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :chmod755, "app config db lib public vendor script script/* public/disp*"
ssh_options[:forward_agent] = true
ssh_options[:port] = 922
set :use_sudo, true
set :scm_verbose, true
set :rails_env, "production"

#############################################################
#	Servers
#############################################################

user = STDIN.gets.chomp
set :user, user
set :domain, "semaprod3"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	hg
#############################################################

set :scm, :mercurial
set :deploy_via, :checkout
#set :checkout, "export"
set :scm_user, user
set :repository, "ssh://sematrac//home/code.hg/mgm.semaphoremobile.com"

#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Create the database yaml file"
  task :after_update_code do
    #set :db_user, Capistrano::CLI.ui.ask("database admin user: ")
    set :db_user, application
    #set :db_pass, Capistrano::CLI.password_prompt("database password - application: ")
    set :db_pass, '4$&7ya'
    db_config = <<-EOF
    #{rails_env}:
      adapter: mysql
      encoding: utf8
      socket: /var/run/mysqld/mysqld.sock
      username: #{db_user}
      password: #{db_pass}
      database: #{application}_#{rails_env}
      host: localhost
    EOF

    put db_config, "#{release_path}/config/database.yml"


#    #gmail integration
#    set :email_tls, 'true'
#    set :email_address, 'smtp.gmail.com'
#    set :email_port, '587'
#    set :email_domain, 'gmail.com'
#    set :email_auth, ':login'
#    set :email_user, 'redmine@semaphoremobile.com'
#    set :email_pass, '4$&7ya'
#    email_config = <<-EOF
#    #{rails_env}:
#      delivery_method: :smtp
#      smtp_settings:
#        tls: #{email_tls}
#        address: #{email_address}
#        port: #{email_port}
#        domain: #{email_domain}
#        authentication: #{email_auth}
#        user_name: #{email_user}
#        password: #{email_pass}
#    EOF
#
#    put email_config, "#{release_path}/config/email.yml"
#
#
#    email_require = <<-EOF
#
#    #gmail integration
#    require 'tlsmail'
#    Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
#
#    EOF

    #File.open("#{release_path}/config/environments/#{rails_env}.rb", 'a') {|f| f.write(email_require) }
    create_vhost
    #########################################################
    # Uncomment the following to symlink an uploads directory.
    # Just change the paths to whatever you need.
    #########################################################

    # desc "Symlink the upload directories"
    # task :before_symlink do
    #   run "mkdir -p #{shared_path}/uploads"
    #   run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
    # end
  end

  desc "Create VHost"
  task :create_vhost do
vhost = <<-EOF
    <VirtualHost *:80>
      ServerAlias #{app_full_name}
      DocumentRoot #{deploy_to}/current/public
      <Directory #{deploy_to}/current/public>
         AllowOverride all
         Options -MultiViews
      </Directory>

      RailsEnv #{rails_env}
    </VirtualHost>
    EOF

    put vhost, "#{release_path}/config/vhost"
    sudo "mv #{release_path}/config/vhost /etc/apache2/sites-available/#{app_full_name}"
    sudo "a2ensite #{app_full_name}"
    sudo "/etc/init.d/apache2 reload"
  end

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
