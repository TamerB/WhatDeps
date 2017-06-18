require 'bundler'

namespace :WhatDeps do
	desc 'Lists required system libraries'
	task show: :environment do
		packages = Bundler.load.specs.map(&:name)
		os = WhatOS.detect
		result = WhatDepsService.new(packages, os)
		dependencies = result.get_libs
		unrecognized = result.get_unrecognized

		if unrecognized.any?
			puts "I don't recognise the following gems."
			puts unrecognized.join(', ')

			#unrecognized.each do |pkg|
			#	print 'Do you know the system libraries needed for #{pkg} (y/n)?
			#	You can add multiple dependencies seperated by (,) e.g. dep1,dep2,....
			#	To pass to the next gem type n'
			#	puts 'To exit type "exit"'
			#	
			#	STDOUT.flush
			#	deps = STDIN.gets.chomp.split(',')
#
			#	break if deps.length == 1 && deps[0].downcase == 'exit'
			#	next if deps.empty? || deps.length == 1 && deps[0].downcase == 'n'

				# Send a post request to add gem and its system libraries
			#	WhatDepsService.create(pkg, deps, os) if deps.downcase == 'y'
			#end
		end

		# this line displays in case of no required libs
		abort 'All set already. No dependencies to be installed' if dependencies.empty?

		# this line should be concatinated to system libs in the response
		print "Your project needs the following dpendencies to be installed into your system:
		#{dependencies.join(', ')}"

		puts 'Would you like me to install them for you? (y/n)'
		STDOUT.flush
		input = STDIN.gets.chomp

		if input.downcase == 'y'
			status = Installer.install(dependencies, os)

			if status[:success].present?
				puts 'The following dependencies have been installed:' + 
				status[:success].join(', ') + '\n
				Ship is ready to sail. Good luck :)'
			else
				puts "Sorry, I couldn't install the following dependencies:" +
				status[:fail].join(', ')
			end
		end
		abort 'Goodbye :)'
	end
end