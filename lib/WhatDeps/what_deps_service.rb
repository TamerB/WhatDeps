require 'httparty'

class WhatDepsService
	include httparty

	basic_url 'http://localhost:3000'

	def initialize(gem, os)
		@options = {query: {packages: gems, os: os, pack_type: 'gem'}}
		@packages = load_deps(@options)
	end

	def get_libs
		@packages['dependencies'].reject { |dep| dep_exists?(pkg)}
	end

	def get_unrecognized
		@packages['unrecognized']
	end

	private

	def load_deps(options)
		deps = self.class.get("/package", options).to_json
	end

	def dep_exists?(dep)
		system("which #{dep}")
	end
end