require 'bundler'

namespace :WhatDeps do
	desc 'Lists required system libraries'
	task show: :environment do
		packages = Bundler.load.specs.map(&:name)
		os = WhatOS.detect
		result = WhatDepsService.new(packages, os)

		abort "Sorry, Internal server error" if result == "connection Refused"

		dependencies = result.get_libs
		unrecognized = result.get_unrecognized

		if unrecognized.any?
			puts "\nI don't recognise the following gems:\n"
			puts unrecognized.join(', ')

			unrecognized.each do |pkg|
				print "\nDo you know the system libraries needed for #{pkg}?\n\n"
				puts "To add dependencies enter them and press enter"
				puts "You can add multiple dependencies seperated by (,) e.g. dep1,dep2,...."
				puts "To pass to the next gem type n"
				puts "To exit this section type 'e'\n"
				
				STDOUT.flush
				deps = STDIN.gets.chomp.split(',')

				break if deps.length == 1 && deps[0].downcase == 'exit' || deps[0].downcase == 'e'
				next if deps.empty? || deps.length == 1 && deps[0].downcase == 'n'

				# Send a post request to add gem and its system libraries
				begin
					result.create(pkg, deps, os)
				rescue
					abort "Sorry, there's a problem connecting to our server"
				end
				dependencies = dependencies.concat(deps)
			end
		end

		# this line displays in case of no required libs
		abort "No required system libraries found.\nGood Bye :)" if dependencies.empty?

		# this line should be concatinated to system libs in the response
		print "\nYour project needs the following dpendencies to be installed into your system:\n\n"
		puts dependencies.join(', ')

		puts "\n\nWould you like me to install them for you? (y/n)\n"
		STDOUT.flush
		input = STDIN.gets.chomp

		if input.downcase == 'y'
			status = Installer.install(dependencies, os)

			if status[:success].present?
				puts "\nThe following dependencies have been installed:\n" 
				print status[:success].join(', ')
			else
				puts "\nSorry, I couldn't install the following dependencies:\n"
				puts status[:fail].join(', ')
			end
		end
		abort "\nGoodbye :)"
	end
end