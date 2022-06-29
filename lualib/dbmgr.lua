dbmgr = {db = nil}

function dbmgr:connect(sql, db_name, max_packet_size)
	self.db = sql.connect(db_name, max_packet_size);
end

return dbmgr
