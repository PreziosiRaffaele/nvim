-- All vim options are now managed in rpreziosi.options
-- See lua/rpreziosi/options.lua for all vim settings
require("rpreziosi.lazy_init")
-- Setup custom commands and functionality
require("rpreziosi.gitlab").setup()
