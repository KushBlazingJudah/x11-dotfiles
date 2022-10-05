local settings = require("settings")
local webview = require "webview"
local window = require "window"
local noscript = require "noscript"

settings.window.home_page = "file://" .. os.getenv("HOME") .. "/.local/share/wsj/startpage.html"
settings.webview.enable_fullscreen = false
settings.window.reuse_new_tab_pages = true
settings.webview.enable_html5_database = false
settings.webview.enable_html5_local_storage = false
settings.webview.enable_offline_web_application_cache = false
settings.application.prefer_dark_mode = true
settings.webview.enable_java = false

local engines = settings.window.search_engines
engines.default = "https://searx.be/search?q=%s"

noscript.enable_scripts = false
noscript.enable_plugins = false

webview.add_signal("init", function (v)
	v:add_signal("navigation-request", function (view, uri)
		local url = uri:gsub("^([%w][%w%+%-%.]*)%:", "")
		local domain, path
		url = url:gsub("^//([^/]*)", function(e)
			domain = e:gsub("^www.", "")
			return ""
		end)
		path = url

		if domain == "youtube.com" then
			view.uri = "https://yewtu.be" .. path
		elseif domain == "twitter.com" then
			view.uri = "https://nitter.snopyta.org" .. path
		elseif domain == "reddit.com" or domain == "old.reddit.com" then
			view.uri = "https://libreddit.kavin.rocks" .. path
		elseif domain == "instagram.com" then
			view.uri = "https://bibliogram.froth.zone" .. path
		elseif domain == "translate.google.com" then
			view.uri = "https://translate.riverside.rocks" .. path
		elseif domain == "google.com" and path:match("^search") ~= nil then
			view.uri = "https://searx.be" .. path
		end
	end)
end)
