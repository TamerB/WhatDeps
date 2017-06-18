require 'os'

class WhatOS
	class << self
		def detect
			if OS.linux?
				return 'linux'
			elsif OS.mac?
				return 'macos'
			else
				return 'unknown'
			end
		end
	end
end