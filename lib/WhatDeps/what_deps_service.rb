require 'httparty'

class WhatDepsService
	include HTTParty

	base_uri 'http://localhost:3000'

	def initialize(pkg, os)
		@options = {query: {packages: pkg, os: os, pack_type: 'gem'}}
		@packages = load_deps(@options)
	end

	def get_libs
		@packages['dependencies'].reject { |dep| dep_exists?(pkg)}
	end

	def get_unrecognized
		@packages['unrecognized']
	end

	def self.create(pkg, deps, os)
		options = {body: {package: pkg, os: os, pack_type: 'gem', deps: deps}}
		self.class.post('/add', options)
	end

	private

	def load_deps(options)
		deps = self.class.get("/package", options)
		JSON.parse(deps.to_json)
	end

	def dep_exists?(dep)
		system("which #{dep}")
	end
end