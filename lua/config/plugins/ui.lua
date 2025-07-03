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
  if #file ~= 0 and vim.bo.modified then
    return file .. " 󰷫"
  end
  return file
end

return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      vim.opt.ls = 3 -- This needs to be setup before lualine

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

  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      vim.notify = notify
      notify.setup({
        background_colour = "#000000",
        merge_duplicates = true,
      })
    end,
  },

  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        relative = "editor",
        win_options = {
          winblend = 0,
        },
        select = {
          win_options = {
            winblend = 0,
          },
        },
      },
    },
  },

  {
    "alvarosevilla95/luatab.nvim",
    config = function()
      require("luatab").setup({})
    end,
  },

  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("barbecue").setup()
    end,
  },
}
