local M = {}

M.check_collision = function(a, b)
	-- If there's an hitbox function, use it
	-- Otherwise, use object itself
	a = a.hitbox and a:hitbox() or a
	b = b.hitbox and b:hitbox() or b
	if a.x + a.width < b.x or a.x > b.x + b.width then
		return false
	end

	if a.y + a.height < b.y or a.y > b.y + b.height then
		return false
	end

	return true
end

return M
