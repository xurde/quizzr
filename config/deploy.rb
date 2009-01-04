load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

# be sure to change these
set :user, 'xurdeor'
set :domain, 'xurdeonrails.com'
set :application, 'quizzr'

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
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end