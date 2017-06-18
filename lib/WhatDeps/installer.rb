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
			{success: success, fail: fails}
		end

		private

		def linux_install(dep)
			system("sudo apt-get -y install #{dep}")
		end

		def macos_install(dep)
			system("bower install #{dep} --no-interactive")
		end
	end
end

class UnsupportedOS < StandardError; end