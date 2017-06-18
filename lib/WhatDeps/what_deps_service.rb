require 'httparty'
require 'json'

class WhatDepsService
	include HTTParty

	base_uri 'http://localhost:3000'

	def initialize(pkg, os)
			@options = {query: {packages: pkg, os: os, pack_type: 'gem'}}
			@packages = load_deps(@options)
	end

	def get_libs
		begin
			@packages['dependencies'].reject { |dep| dep_exists?(dep)}
		rescue
			[]
		end
	end

	def get_unrecognized
		@packages['unrecognized']
	end

	def create(pkg, deps, os)
		options = {body: {package: pkg, os: os, pack_type: 'gem', dependencies: deps}}
		self.class.post('/add', options)
	end

	private

	def load_deps(options)
		begin
			deps = self.class.get("/package", options)
			JSON.parse(deps.to_json)
		rescue
			abort "Sorry, there's a problem connecting to our server"
		end
	end

	def dep_exists?(dep)
		system("which #{dep}")
	end
end