local statusline_ok, statusline = pcall(require, "mini.statusline")
if not statusline_ok then
    return
end

local signs = { E = " ", W = " ", H = "󰌵 ", I = " " }

local function replace(match)
    return signs[match] or match
end

local section_diagnostics = function()
    local diagnostics = MiniStatusline.section_diagnostics({
        trunc_width = 75,
        icon = "",
    })
    if string.find(diagnostics, "-") then
        return ""
    end
    return diagnostics:gsub(".", replace)
end

local rec_output = function()
    return "recording @" .. vim.fn.reg_recording()
end

local is_recording = function()
    if vim.fn.reg_recording() ~= "" then
        return true
    end
    return false
end

local is_modified = function()
    local filename = vim.fn.expand("%:t")
    if vim.bo.modified then
        return filename .. " 󰷫"
    end
    return filename
end

local active = function()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    local git = MiniStatusline.section_git({ trunc_width = 75 })
    local diagnostics = section_diagnostics()
    -- local filename = MiniStatusline.section_filename({ trunc_width = 140 })
    local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
    local location = MiniStatusline.section_location({ trunc_width = 75 })
    local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
    local recording = is_recording() and rec_output() or ""
    local modified = is_modified()

    return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { modified } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { recording } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
    })
end

statusline.setup({
    content = {
        active = active,
        inactive = nil,
    },
    use_icons = true,
    set_vim_statusline = false,
})
