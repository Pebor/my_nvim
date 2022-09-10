require('plugins')
require('settings')
require('mappings')
local modules = {
  "plugins",
  "settings",
  "mappings",
}

-- Refresh module cache
for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
