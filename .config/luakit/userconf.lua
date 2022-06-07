local settings = require("settings")

settings.window.home_page = "file://" .. os.getenv("HOME") .. "/.local/share/wsj/startpage.html"
settings.webview.enable_fullscreen = false
settings.window.reuse_new_tab_pages = true
settings.webview.enable_html5_database = false
settings.webview.enable_html5_local_storage = false
settings.webview.enable_offline_web_application_cache = false
settings.application.prefer_dark_mode = true
settings.webview.enable_java = false
