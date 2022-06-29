function class(base)
	local _class = {}
	_class.constructor = false
	_class.base = base
	_class.new = function (...)
		local sub_obj = {}
		local create
		create = function (c, ...)
			if c.base then
				create(c.base, ...)
			end
			if c.constructor then
				c.constructor(sub_obj, ...)
			end
		end
		create(_class)
		setmetatable(sub_obj, {__index = _class})
		return sub_obj
	end
	return _class
end

return class