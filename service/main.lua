local skynet = require "skynet"
local dbmgr = require "dbmgr"
local mysqldb = require "mysqldb"
local http_server = require "httpserver"

skynet.start(function()
    -- 连接到数据库
    -- dbmgr:connect(mysqldb:new(), "game", 1024 * 1024)
    local login_server = http_server.new()
    login_server:work("127.0.0.1", 8089, 5, 8192);
end)
