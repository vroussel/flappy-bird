local M = {}

M.check_collision = function(a, b)
	if a.x + a.width < b.x or a.x > b.x + b.width then
		return false
	end

	if a.y + a.height < b.y or a.y > b.y + b.height then
		return false
	end

	return true
end

return M
