local skynet = require "skynet"
local socket = require "skynet.socket"
local httpd = require "http.httpd"
local sockethelper = require "http.sockethelper"
local urllib = require "http.url"
require "skynet.manager"

local function err_response(id,...)
	local ok, err = httpd.write_response(sockethelper.writefunc(id), ...)
	if not ok then
		skynet.error("response failed: " .. id .. err )
	end
end

skynet.start(
	function()
		skynet.dispatch("lua",
			function(_, _, id, ...)
				-- 一个新服务需要重新start
				socket.start(id)
				local ok, url, method, header, body = httpd.read_request(sockethelper.readfunc(id), ...)
				skynet.error("ok:"..ok .."\nurl:"..url .. "\nbody:"..body);
				if ok then
					if ok ~= 200 then
						err_response(id, ok)
					else 
						local path, query = urllib.parse(url)
						if query then
							local q = urllib.parse_query(query)
							for k, v in pairs(q) do
								skynet.error(k .. v);
							end
						end
					end
				end
			end
		)
		skynet.register(".httpagent")
	end
)
