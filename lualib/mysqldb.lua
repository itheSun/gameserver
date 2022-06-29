local skynet = require "skynet"
local mysql = require "skynet.db.mysql"
local class = require "/common/class"

mysqldb = class()

mysqldb.host = '127.0.0.1'
mysqldb.port = 3306
mysqldb.user = 'root'
mysqldb.password = 'admin'

function mysqldb:connect(db_name, max_packet_size)
	local function on_connect()
		skynet.error("连接到mysql--" .. db_name .. "--数据库")
	end

	local db = mysql.connect({
		host = mysqldb.host,
		port = mysqldb.port,
		database = db_name,
		user = mysqldb.user,
		password = mysqldb.password,
		max_packet_size = max_packet_size,
		on_connect = on_connect
	})
	if not db then
		skynet.error("连接到mysql数据库失败！")
	end
	return db
end

return mysqldb
