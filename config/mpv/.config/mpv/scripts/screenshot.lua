local mputils = require 'mp.utils'
local basedir = mp.get_property("options/screenshot-directory")

function make_screenshot_dir()
    local filedir = mp.get_property("filename/no-ext")
    local fulldir = mputils.join_path(basedir, filedir)
    mp.set_property("options/screenshot-directory", fulldir)
end

mp.register_event("file-loaded", make_screenshot_dir)
