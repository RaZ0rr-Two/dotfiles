local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand '%:t') == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end
--[[
function M.Icons(name)
	if name == 0 then
		return string.format(" %q ", "")
	end
	if name == 1 then
		return string.format(" %q ", "")
	end
end
]]--

function M.LinesInfo()
  local line = vim.fn.line('.')
  local column = vim.fn.col('.')
  local total_line = vim.fn.line('$')
  return string.format("%d:%d  %d", column, line, total_line)
end

function M.Icons(name)
	if name == 0 then
		return ""
	end
	if name == 1 then
		return ""
	end
end

function M.unixIcon() return string.format(" %q ", "") end
function M.unix() return "" end
function M.macIcon() return string.format(" %q ", "") end

function M.TotalLinenr()
  local total_line = vim.fn.line('$')
  return string.format("%3d", total_line)
end

function M.lspShow()
  local msg = ''
  local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end

  for _,client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

return M
