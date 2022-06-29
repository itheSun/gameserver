local skynet = require "skynet"
local socket = require "skynet.socket"

http_server = class()
function http_server:work(host, port, count, limit)
    local agent = {}
    for i = 1, count, 1 do
        agent[i] = skynet.newservice("httpagent")
    end
    skynet.error("创建了"..count.."个代理服务")
    local index = 1
    local id = socket.listen(host, port)
    skynet.error("正在监听"..port.."端口".."    --"..host)
    socket.start(id, function(id, addr)
        skynet.error(addr .. "连接到" .. index .. "服务器" .. port .. "端口")
        skynet.send(agent[index], "lua", id, limit)
        index = (index + 1) % count
    end)
end

return http_server
