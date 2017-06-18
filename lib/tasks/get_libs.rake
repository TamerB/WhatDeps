

namespace :WhatDeps do
	desc 'Lists required system libraries'
	task show: :environment do
		packages = Bundler.load.specs.map(&:name)
		os = WhatOs.detect
		result = WhatDeps.new(packages, os)
		dependencies = result.get_libs
		unrecognized = result.get_unrecognized

		if unrecognized.any?
			puts "I don't recognise the following gems.".
			puts unrecognized.join(', ')

			unrecognized.each do |gem|
				print 'Do you know the system libraries needed for #{gem} ? \n
				You can add multiple dependencies seperated by (,) e.g. dep1,dep2,....\n
				To pass to the next gem type next'
				puts 'To exit type "exit"'
				
				STDOUT.flush
				deps = STDIN.gets.chomp.split(',')

				break if deps.length == 1 && deps[0].downcase == 'exit'
				next if deps.empty? || deps.length == 1 && deps[0].downcase == 'next'

				# Send a post request to add gem and its system libraries
			end
		end

		# this line displays in case of no required libs
		abort 'All set already. No dependencies to be installed' if dependencies.empty?

		# this line should be concatinated to system libs in the response
		print "Your project needs the following dpendencies to be installed into your system:\n
		#{dependencies.join(', ')}"

		puts 'Would you like me to install them for you? (y/n)'
		STDOUT.flush
		input = STDIN.get.chomp

		if input.downcase == 'y'
			status = Installer.install(dependencies, os)

			if status[:success].present?
				abort 'The following dependencies have been installed:\n' + 
				status[:success].join(', ') + '\n
				Ship is ready to sail. Good luck :)'
			else
				abort "Sorry, I couldn't install the following dependencies:\n" +
				status[:fail].join(', ')
			end

		end
	end
end