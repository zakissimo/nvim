M = {}

math.randomseed(os.clock())

M.setup = {
    win_w = vim.o.columns / 2,
    win_h = vim.o.lines / 2,
}

M.kb = {
    { "`1234567890-=", "qwertyuiop[]\\", "asdfghjkl;'", "zxcvbnm,./" },
    { "~!@#$%^&*()_+" },
    -- { "~!@#$%^&*()_+", "QWERTYUIOP{}|", 'ASDFGHJKL:"', "ZXCVBNM<>?" },
}

local get_random_line = function()
    local case_idx = math.random(1, #M.kb)
    local row_idx = math.random(1, #M.kb[case_idx])
    local row_len = string.len(M.kb[case_idx][row_idx])
    local key_idx = math.random(1, row_len)
    local key = string.sub(M.kb[case_idx][row_idx], key_idx, key_idx)
    local padding = (key_idx - 1) * M.setup.win_w / row_len

    return string.rep(" ", padding) .. key
end

M.display = { get_random_line() }

M.config = {
    title = "FallinKeys",
    title_pos = "center",
    relative = "editor",
    width = M.setup.win_w,
    height = M.setup.win_h,
    col = math.floor((vim.o.columns - M.setup.win_w) / 2),
    row = math.floor(((vim.o.lines - M.setup.win_h) / 2) - 1),
    style = "minimal",
    border = "rounded",
}

-- M.bufnr = vim.api.nvim_create_buf(false, true)
-- vim.api.nvim_buf_set_name(M.bufnr, "fallinKeys")
-- vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, M.display)
-- vim.api.nvim_open_win(M.bufnr, true, M.config)
