from fabric.api import *

env.hosts = ['tgwizard.com']

def deploy():
	local('git push')

	code_dir = '/var/www/r'
	with cd(code_dir):
		run('git pull -f')
		run('make install_deps')
