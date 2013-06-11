set :application, "rptiv"

set :repository,  "https://github.com/yanatan16/RaspberryPiTV"
set :deploy_to, '/home/pi/app'
set :scm, :git
set :branch, 'master'

server "rpitv-jon", :app
set :user, 'pi'

set :public_children, ['css', 'font', 'images', 'js']

namespace :deploy do

	namespace :node do
	  desc "Stop Forever"
	  task :stop do
	    run "sudo forever stopall" rescue nil
	  end

	  desc "Start Forever"
	  task :start do
	    run "cd #{current_path} && sudo forever start start -a forever.log -o out.log -e err.log app.js"
	  end

	  desc "Restart Forever"
	  task :restart do
	    stop
	    sleep 5
	    start
	  end
	end

	desc "Restart the app"
	task :restart, :roles => :app, :except => { :no_release => true } do
		node.restart
	end

	desc "Refresh the npm install"
	task :finalize_update do
		refresh_symlink
		npm_install
	end

  desc "Refresh shared node_modules symlink to current node_modules"
  task :refresh_symlink do
    run "rm -rf #{current_path}/node_modules && ln -s #{shared_path}/node_modules #{current_path}/node_modules"
  end

  desc "Install node modules non-globally"
  task :npm_install do
    run "cd #{current_path} && npm install"
  end
end