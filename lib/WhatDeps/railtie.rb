require 'rails'

module WhatDeps
	class Railtie < Rails::Railtie
		rake_tasks do
			load 'tasks/get_libs.rake'
		end
			
		end
	end
end