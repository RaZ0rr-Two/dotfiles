local gl = require 'galaxyline'
-- local utils = require 'conf.utils'
local condition = require 'galaxyline.condition'
local diagnostic = require 'galaxyline.provider_diagnostic'
local utils = require 'plugins.galaxyline..utils'
local devicons = require 'nvim-web-devicons'

local gls = gl.section
gl.short_line_list = { 'packer', 'fernTree', 'NvimTree', 'Outline', 'LspTrouble' }

local colors = {
    bg = '#282c34',
    fg = '#abb2bf',
    section_bg = '#38393f',
    -- blue = '#61afef',
    light_green = '#98c379',
    orange = '#f08700',
    red = '#e06c75',
    yellow = '#eae639',
    darkgrey = '#2c323d',
    middlegrey = '#8791A5',
    cream = '#DCDCAA',
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    green = '#608B4E',
    lightest_green = '#B5CEA8',
    string_orange = '#CE9178',
    purple = '#C586C0',
    magenta = '#D16D9E',
    grey = '#858585',
    blue = '#569CD6',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    -- red = '#D16969',
    error_red = '#F44747',
    info_yellow = '#FFCC66'
}
local icons = {
    -- locker = u 'f023',
    -- unsaved = u 'f693',
    -- dos = u 'e70f',
    -- unix = u 'f17c',
    -- unix = '' ,
    unix = utils.Icons(0),
    mac = utils.Icons(1),
    --unix = utils.unixIcon(),
    --mac = utils.macIcon(),
    -- mac = u 'f179',
    -- lsp_warn = u 'f071',
    -- lsp_error = u 'f46e',
}
-- Local helper functions

-- local function TotalLinenr()
--   local total_line = vim.fn.line('$')
--   return string.format("%3d", total_line)
-- end

local function is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand '%:t') == 1
end

local function has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

local buffer_not_empty = function()
    return not utils.is_buffer_empty()
end

local checkwidth = function()
    return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value[1] == val then
            return true
        end
    end
    return false
end

local mode_color = function()
    local mode_colors = {
        [110] = colors.green,
        [105] = colors.blue,
        [99] = colors.green,
        [116] = colors.blue,
        [118] = colors.purple,
        [22] = colors.purple,
        [86] = colors.purple,
        [82] = colors.red,
        [115] = colors.red,
        [83] = colors.red,
    }

    local color = mode_colors[vim.fn.mode():byte()]
    if color ~= nil then
        return color
    else
        return colors.purple
    end
end

local function file_readonly()
    if vim.bo.filetype == 'help' then
        return ''
    end
    if vim.bo.readonly == true then
        return '  '
    end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand '%:t'
    if vim.fn.empty(file) == 1 then
        return ''
    end
    if string.len(file_readonly()) ~= 0 then
        return file .. file_readonly()
    end
    if vim.bo.modifiable then
        if vim.bo.modified then
            return file .. '  '
        end
    end
    return file .. ' '
end

local function split(str, sep)
    local res = {}
    local n = 1
    for w in str:gmatch('([^' .. sep .. ']*)') do
        res[n] = res[n] or w -- only set once (so the blank after a string is ignored)
        if w == '' then
            n = n + 1
        end -- step forwards on a blank but not a string
    end
    return res
end

-- local function trailing_whitespace()
--     local trail = vim.fn.search('\\s$', 'nw')
--     if trail ~= 0 then
--         return '  '
--     else
--         return nil
--     end
-- end

-- local function tab_indent()
--     local tab = vim.fn.search('^\\t', 'nw')
--     if tab ~= 0 then
--         return ' → '
--     else
--         return nil
--     end
-- end

-- local function buffers_count()
--     local buffers = {}
--     for _, val in ipairs(vim.fn.range(1, vim.fn.bufnr('$'))) do
--         if vim.fn.bufexists(val) == 1 and vim.fn.buflisted(val) == 1 then
--             table.insert(buffers, val)
--         end
--     end
--     return #buffers
-- end

local function get_basename(file)
    return file:match '^.+/(.+)$'
end

local GetGitRoot = function()
    local git_dir = require 'galaxyline.provider_vcs'.get_git_dir()
    if not git_dir then
        return ''
    end

    local git_root = git_dir:gsub('/.git/?$', '')
    return get_basename(git_root)
end

local LspStatus = function()
    if #vim.lsp.get_active_clients() > 0 then
        return require 'lsp-status'.status()
    end
    return ''
end

local LspCheckDiagnostics = function()
    if
        #vim.lsp.get_active_clients() > 0
        and diagnostic.get_diagnostic_error() == nil
        and diagnostic.get_diagnostic_warn() == nil
        and diagnostic.get_diagnostic_info() == nil
        -- and require 'lsp-status'.status() == ' '
    then
        return ' '
    end
    return ''
end

-- Left side
gls.left[1] = {
    ViMode = {
        provider = function()
            local aliases = {
                [110] = 'NORMAL',
                [105] = 'INSERT',
                [99] = 'COMMAND',
                [116] = 'TERMINAL',
                [118] = 'VISUAL',
                [22] = 'V-BLOCK',
                [86] = 'V-LINE',
                [82] = 'REPLACE',
                [115] = 'SELECT',
                [83] = 'S-LINE',
            }
            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
            local alias = aliases[vim.fn.mode():byte()]
            local mode
            if alias ~= nil then
                if has_width_gt(35) then
                    mode = alias
                else
                    mode = alias:sub(1, 1)
                end
            else
                mode = vim.fn.mode():byte()
            end
            return '  ' .. mode .. ' '
        end,
        highlight = { colors.bg, colors.bg, 'bold' },
    },
}
gls.left[2] = {
     FileIcon = {
        provider = { function()
            return '  '
        end, 'FileIcon' },
        condition = buffer_not_empty,
        highlight = {
             require 'galaxyline.provider_fileinfo'.get_file_icon_color,
            colors.section_bg,
         },
     },
}
gls.left[3] = {
    FilePath = {
        provider = function()
            local fp = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.:h')
            local tbl = split(fp, '/')
            local len = #tbl

            if len > 2 and not len == 3 and not tbl[0] == '~' then
                return '…/' .. table.concat(tbl, '/', len - 1) .. '/' -- shorten filepath to last 2 folders
                -- alternative: only 1 containing folder using vim builtin function
                -- return '…/' .. vim.fn.fnamemodify(vim.fn.expand '%', ':p:h:t') .. '/'
            else
                return fp .. '/'
            end
        end,
        condition = checkwidth,
        highlight = { colors.middlegrey, colors.section_bg },
    },
}
gls.left[4] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = { colors.fg, colors.section_bg },
        separator = '',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}
-- gls.left[4] = {
--     WhiteSpace = {
--         provider = trailing_whitespace,
--         condition = buffer_not_empty,
--         highlight = {colors.fg, colors.bg}
--     }
-- }
-- gls.left[5] = {
--     TabIndent = {
--         provider = tab_indent,
--         condition = buffer_not_empty,
--         highlight = {colors.fg, colors.bg}
--     }
-- }
gls.left[8] = {
    DiagnosticsCheck = {
        provider = { LspCheckDiagnostics },
        highlight = { colors.middlegrey, colors.bg },
    },
}
gls.left[9] = {
    DiagnosticError = {
        provider = { 'DiagnosticError' },
        icon = '  ',
        highlight = { colors.red, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.bg, colors.bg}
    },
}
-- gls.left[10] = {
--     Space = {
--         provider = function() return ' ' end,
--         highlight = {colors.section_bg, colors.bg}
--     }
-- }
gls.left[11] = {
    DiagnosticWarn = {
        provider = { 'DiagnosticWarn' },
        icon = '  ',
        highlight = { colors.orange, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.bg, colors.bg}
    },
}
-- gls.left[12] = {
--     Space = {
--         provider = function() return ' ' end,
--         highlight = {colors.section_bg, colors.bg}
--     }
-- }
gls.left[13] = {
    DiagnosticInfo = {
        provider = { 'DiagnosticInfo' },
        icon = '  ',
        highlight = { colors.blue, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.section_bg, colors.bg}
    },
}
gls.left[14] = {
    LspStatus = {
            provider = function()
                local connected =
                  not vim.tbl_isempty(vim.lsp.buf_get_clients(0))
                if connected then
                    return '  '
                else
                    return ''
                end
            end,
            highlight = {colors.blue, colors.bg},
            separator = '',
            separator_highlight = 'GalaxyViModeInv',
    },
}

-- Right side
-- gls.right[0] = {
--     ShowLspClient = {
--         provider = 'GetLspClient',
--         condition = function()
--             local tbl = {['dashboard'] = true, [''] = true}
--             if tbl[vim.bo.filetype] then return false end
--             return true
--         end,
--         icon = ' ',
--         highlight = {colors.middlegrey, colors.bg},
--         separator = ' ',
--         separator_highlight = {colors.section_bg, colors.bg}
--     }
-- }
gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '+',
        highlight = { colors.green, colors.bg },
        separator = ' ',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}
gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = { colors.orange, colors.bg },
    },
}
gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = { colors.red, colors.bg },
    },
}
gls.right[4] = {
    Space = {
        provider = function()
            return ' '
        end,
        highlight = { colors.section_bg, colors.bg },
    },
}
gls.right[6] = {
    GitBranch = {
        provider = {
            function()
                return '  '
            end,
            'GitBranch',
        },
        condition = condition.check_git_workspace,
        highlight = { colors.middlegrey, colors.bg },
    },
}
gls.right[7] = {
    GitRoot = {
        provider = { GetGitRoot },
        condition = function()
            return utils.has_width_gt(50) and condition.check_git_workspace
        end,
        -- icon = '  ',
        highlight = { colors.fg, colors.bg },
        separator = ' ',
        separator_highlight = { colors.middlegrey, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.section_bg, colors.bg}
    },
}gls.right[8] = {
		LineInfo = {
        -- provider = {'LineColumn', function() return ' ' end},
				provider = utils.LinesInfo,
				highlight = {colors.darkgrey, colors.yellow},
				separator = '',                    	
				separator_highlight = {colors.yellow, colors.bg}
		}
}
-- gls.right[9] = {
-- 		TotalLine = {
-- 				provider = utils.TotalLinenr,
-- 				highlight = {colors.darkgrey, colors.yellow},
-- 				separator = '並',
-- 				separator_highlight = {colors.darkgrey, colors.yellow}
-- 		}
-- }
gls.right[9] = {
    PerCent = {
        provider = {'LinePercent', function() return ' ' end},
        separator = ' ,',
        separator_highlight = { colors.blue, colors.yellow },
        highlight = { colors.darkgrey, colors.blue },
    },
}
gls.right[10] = {
		FileEncode = {
      provider = {'FileEncode', function() return ' ' end},
      highlight = {colors.fg, colors.section_bg},
			separator = ' ',
      separator_highlight = {colors.blue, colors.section_bg}
    }
}

gls.right[11] = {
		BufferType = {
		provider = utils.unix,
      -- provider = {'FileTypeName', function() return ' ' end},
			--provider = function()
				-- if FileTypeName == "UNIX" then
				-- return {'FileTypeName', function() return ' ' end, icons.unix}
			--end,
				-- [[ if FileTypeName == "" then
				-- 		return {'FileTypeName', function() return ' ' end, ''}
				-- end ]]
  		-- end,  
		highlight = {colors.red, colors.section_bg},
      separator = '',
      separator_highlight = {colors.section_fg, colors.section_bg}
		}
}

gls.right[12] = {
		FileSize = {
      provider = {function() return '  ' end, 'FileSize'},
      highlight = {colors.fg, colors.section_bg},
      separator = '',
      separator_highlight = {colors.section_fg, colors.section_bg}
		}
}
-- gls.right[9] = {
--     ScrollBar = {
--         provider = 'ScrollBar',
--         highlight = {colors.purple, colors.section_bg}
--     }
-- }

-- Short status line
gls.short_line_left[1] = {
    FileIcon = {
        provider = { function()
            return '  '
        end, 'FileIcon' },
        condition = function()
            return buffer_not_empty and has_value(
                gl.short_line_list,
                vim.bo.filetype
            )
        end,
        highlight = {
            require 'galaxyline.provider_fileinfo'.get_file_icon,
            colors.section_bg,
        },
    },
}
gls.short_line_left[2] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = { colors.fg, colors.section_bg },
        separator = '',
        separator_highlight = { colors.section_bg, colors.orange },
    },
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = { colors.yellow, colors.section_bg },
        separator = '',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
