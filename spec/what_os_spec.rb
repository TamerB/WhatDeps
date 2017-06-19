require "spec_helper"

# if you are using linux OS
RSpec.describe WhatDeps do
  it "Linux OS" do
    expect(WhatOS.detect).to eq "linux"
  end
end

=begin

# if you are using macosx
RSpec.describe WhatDeps do
  it "macosx" do
    expect(WhatOS.detect).to eq "macos"
  end
end

# # if you are using another OS

RSpec.describe WhatDeps do
  it "unknown" do
    expect(WhatOS.detect).to eq "unknown"
  end
end

=end