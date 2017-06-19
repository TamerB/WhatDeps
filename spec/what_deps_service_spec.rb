require "spec_helper"

RSpec.describe WhatDeps do
  it "Success GET request (libs)" do
  	service = WhatDepsService.new(['abc', 'def'], 'linux')
    expect(service.get_libs).to eq []
  end
end

RSpec.describe WhatDeps do
  it "Success GET request (unrecognized)" do
  	service = WhatDepsService.new(['abc', 'def'], 'linux')
    expect(service.get_unrecognized).to eq ['abc', 'def']
  end
end

RSpec.describe WhatDeps do
  it "Success GET request (libs) emtpy" do
  	service = WhatDepsService.new([], 'linux')
    expect(service.get_unrecognized).to eq ['']
  end
end

RSpec.describe WhatDeps do
  it "Success GET request (unrecognized) empty" do
  	service = WhatDepsService.new([], 'linux')
    expect(service.get_unrecognized).to eq ['']
  end
end