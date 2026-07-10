return {
  -- Pinned to a personal fork until the upstream fix lands:
  --   https://github.com/coder/claudecode.nvim/pull/303
  -- Fixes the empty [No Name] pane (and tab leak) in the unified new-tab diff.
  -- To revert once merged: change this back to "coder/claudecode.nvim" and drop `branch`.
  "zakissimo/claudecode.nvim",
  branch = "fix/unified-new-tab-empty-pane",
  dependencies = { "folke/snacks.nvim" },
  -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
  -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
  -- spec defers loading until a <leader>a* mapping is pressed and the commands
  -- would not exist yet.
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>a", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
  },
  init = function()
    -- Tint the inline-diff add/delete lines with the active colorscheme's own diff
    -- backgrounds (DiffAdd/DiffDelete) instead of the plugin's hardcoded green/red,
    -- and drop the delete strikethrough (redundant once the line is already red).
    -- Falls back to the plugin's defaults when a theme leaves those groups without a
    -- background. The plugin re-asserts its groups with `default = true` on every
    -- diff open, so this override only needs the groups to stay defined -- re-apply
    -- on ColorScheme since a theme switch clears every highlight group.
    local function sync_diff_hl()
      local add = vim.api.nvim_get_hl(0, { name = "DiffAdd", link = false })
      local del = vim.api.nvim_get_hl(0, { name = "DiffDelete", link = false })
      vim.api.nvim_set_hl(0, "ClaudeCodeInlineDiffAdd", { bg = add.bg or 0x2a4a2a })
      vim.api.nvim_set_hl(0, "ClaudeCodeInlineDiffDelete", { bg = del.bg or 0x4a2a2a })
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = sync_diff_hl })
    sync_diff_hl()
  end,
  opts = {
    terminal = {
      split_side = "right", -- "left" or "right"
      split_width_percentage = 0.45,
      -- Optional: shrink (or widen) the terminal while a diff is open. Defaults to
      -- split_width_percentage when unset, preserving today's behavior.
      diff_split_width_percentage = nil, -- e.g. 0.20 to give diffs more room
      provider = "auto", -- "auto", "snacks", "native", "external", "none", or custom provider table
      auto_close = true,
      -- Auto-enter insert/terminal mode whenever the Claude terminal window gains
      -- focus. Set to false to stay in Normal mode and preserve your scroll position
      -- when switching back to the terminal (e.g. via <C-w>l); press `i` to type.
      -- Note: false also opens the terminal in Normal mode (it gates start-insert too).
      auto_insert = true,
      snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below
      -- Work around a Neovim core bug (< 0.12.2) that fragments large pastes into
      -- the terminal, making Cmd+V appear to truncate ([#161]). true | false | "auto"
      -- ("auto", the default, enables it only on affected Neovim versions).
      fix_streamed_paste = "auto",

      -- Provider-specific options
      provider_opts = {
        -- Command for external terminal provider. Can be:
        -- 1. String with %s placeholder: "alacritty -e %s" (backward compatible)
        -- 2. String with two %s placeholders: "alacritty --working-directory %s -e %s" (cwd, command)
        -- 3. Function returning command: function(cmd, env) return "alacritty -e " .. cmd end
        external_terminal_cmd = nil,
      },
    },
    diff_opts = {
      layout = "unified", -- "vertical" (default), "horizontal", or "unified"
      -- "unified": VS Code-style unified diff in a single buffer with deleted
      --   (red/strikethrough) and added (green) lines interleaved. Requires
      --   Neovim >= 0.9.0. Highlight groups are customizable: ClaudeCodeInlineDiffAdd,
      --   ClaudeCodeInlineDiffDelete, ClaudeCodeInlineDiffAddSign, ClaudeCodeInlineDiffDeleteSign.
      open_in_new_tab = true,
      keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      hide_terminal_in_new_tab = true,
      auto_resize_terminal = false, -- Let the plugin manage the terminal width across the diff lifecycle
      -- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

      -- Legacy aliases (still supported):
      -- vertical_split = true,
      -- open_in_current_tab = true,
    },
  },
}
