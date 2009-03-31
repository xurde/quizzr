load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

# be sure to change these
set :user, 'xurdeor'
set :domain, 'quizzr.net'
set :application, 'quizzr'

# roles
role :app, "quizzr.net" 
role :web, "quizzr.net" 
role :db,  "quizzr.net", :primary => true 

# the rest should be good
set :repository,  "#{user}@#{domain}:git/#{application}.git" 
set :deploy_to, "/home/#{user}/quizzr.net" 
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web

namespace :deploy do
  
  task :after_update_code, :roles => :app do
    run "ln -nfs /home/#{user}/#{domain}/shared/system/avatars #{release_path}/public/images/avatars"
  end
  
  desc "Fix file permissions"
  task :fix_file_permissions, :roles => [ :app, :db, :web ] do 
          sudo "chmod -R g+rw #{current_path}/tmp"
          sudo "chmod -R g+rw #{current_path}/log"
          sudo "chmod -R g+rw #{current_path}/public/system"
  end
  
  desc "Restarting Webserver"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
end