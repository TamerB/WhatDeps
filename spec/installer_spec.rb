require "spec_helper"

RSpec.describe WhatDeps do
	it 'Installation success and failure for linux' do
    	data = %w(vim nano)

    	allow(Installer).to receive(:linux_install)
    	  .with(data[0]).and_return(true)

    	allow(Installer).to receive(:linux_install)
    	  .with(data[1]).and_return(false)

    	expect(Installer.install(data, 'linux')).to eq(success: [data[0]], fail: [data[1]])
	end
end

RSpec.describe WhatDeps do
	it 'Installation success and failure for macosx' do
    	data = %w(vim nano)

    	allow(Installer).to receive(:macos_install)
    	  .with(data[0]).and_return(true)

    	allow(Installer).to receive(:macos_install)
    	  .with(data[1]).and_return(false)

    	expect(Installer.install(data, 'macos')).to eq(success: [data[0]], fail: [data[1]])
	end
end

RSpec.describe WhatDeps do
  it "Installation failure for different OS" do
  	data = ['hi', 'hi2']
    expect(Installer.install(data, 'macos')).to eq(success: [], fail: data)
  end
end

RSpec.describe WhatDeps do
	it 'Installation failure for unknown packages' do
    	data = ['hi', 'hi2']

    	expect(Installer.install(data, 'linux')).to eq(success: [], fail: data)
    end
end