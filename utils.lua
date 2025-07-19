local M = {}

M.check_collision = function(a, b, tolerance)
	tolerance = tolerance or { x = 0, y = 0 }
	if a.x + a.width - tolerance.x < b.x or a.x + tolerance.x > b.x + b.width then
		return false
	end

	if a.y + a.height - tolerance.y < b.y or a.y + tolerance.y > b.y + b.height then
		return false
	end

	return true
end

return M
