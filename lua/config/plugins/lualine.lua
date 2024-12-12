local rec_output = function()
  return "recording @" .. vim.fn.reg_recording()
end

local recording = function()
  if vim.fn.reg_recording() ~= "" then
    return true
  end
  return false
end

local filename = function()
  local file = vim.fn.expand("%:t")
  if vim.bo.modified then
    return file .. " 󰷫"
  end
  return file
end

return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_c = {
            filename,
            {
              rec_output,
              cond = recording,
            },
          },
          lualine_x = {
            "%S",
            "searchcount",
            "selectioncount",
          },
        },
      })
    end,
  },
}
