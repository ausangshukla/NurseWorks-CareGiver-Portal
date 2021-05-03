# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "NurseWorks"
set :repo_url, "https://github.com/thimmaiah/NurseWorks-CareGiver-Portal.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'main'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/NurseWorks"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do

  desc "Uploads .env remote servers."
  task :upload_env do
    on roles(:app) do
      rails_env = fetch(:rails_env)
      puts "Uploading .env files to #{release_path} #{rails_env}"
      upload!("/home/thimmaiah/work/NurseWorks/.env", "#{release_path}", recursive: false)
      upload!("/home/thimmaiah/work/NurseWorks/.env.local", "#{release_path}", recursive: false)
      upload!("/home/thimmaiah/work/NurseWorks/.env.staging", "#{release_path}", recursive: false) if rails_env == :staging
      upload!("/home/thimmaiah/work/NurseWorks/.env.production", "#{release_path}", recursive: false) if rails_env == :production      
    end
  end

  before "deploy:migrate", :upload_env

end