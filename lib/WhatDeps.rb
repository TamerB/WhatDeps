require "WhatDeps/version"
require "WhatDeps/what_deps_service"
require "WhatDeps/what_os"

module WhatDeps
  require "WhatDeps/railtie" if defined? (Rails)
end
