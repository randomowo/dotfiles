local export = {}

function export.current_branch()
	local branch_name = vim.fn['gitbranch#name()']
	if len(branch_name) > 0 then
		return 'b:' .. branch_name
	end
	return ''
end

return export

