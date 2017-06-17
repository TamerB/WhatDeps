

namespace :WhatDeps do
	desc 'Lists required system libraries'
	task show: :environment do
		packages = Bundler.load.specs.map(&:name)
		result = "response from service"
		packages = "packages dependencies"
		unrecognized = "unrecognized packages"

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

		# this line should be contained in an if condition of no required libs
		abort 'All set already. No dependencies to be installed'

		# this line should be concatinated to system libs in the response
		puts 'Your project needs the following dpendencies to be installed into your system:\n'
	end
end