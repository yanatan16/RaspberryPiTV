set :application, "rptiv"
set :repository,  "https://github.com/yanatan16/RaspberryPiTV"
set :deploy_to, '/home/pi/app'
set :strategy, 'copy'

set :scm, :git
set :user, 'pi'

server "rpitv-jon", :app

namespace :deploy do

	namespace :node do
		task :stop, :roles => :app, :except => { :no_release => true } do
			sudo "/etc/init.d/nodejs.sh stop"
		end

		task :start, :roles => :app, :except => { :no_release => true } do
			sudo "/etc/init.d/nodejs.sh start"
		end
	end

	task :restart, :roles => :app, :except => { :no_release => true } do
		node.stop
		node.stop
	end
end