class Installer
	class << self
		def install(deps, os)
			raise UnsupportedOS if os == 'unknown'

			success = []
			fails = []

			deps.each do |dep|
				status = send "#{os}_install", dep

				if status
					success << dep
					puts "success"
				else
					fails << dep
					puts "failure"
				end
			end
			{success: success, fail, fails}
			setup(deps, os)
		end

		private

		def linux_install(dep)
			if system("sudo apt-get -y install #{pkg}").include? "command not found"
				system("sudo yum -y install #{pkg}")
			end
		end

		def macos_install(dep)
			system("bower install #{dep} --no-interactive")
		end
	end
end

class UnsupportedOS < StandardError; end