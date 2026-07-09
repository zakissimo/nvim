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
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
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
      auto_resize_terminal = true, -- Let the plugin manage the terminal width across the diff lifecycle
      -- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

      -- Legacy aliases (still supported):
      -- vertical_split = true,
      -- open_in_current_tab = true,
    },
  },
}
