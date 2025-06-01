return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    opts = {
      -- lang = "rust",
      hooks = {
        ["question_enter"] = {
          function(question)
            local problem_dir = vim.fn.stdpath("data") .. "/leetcode/Cargo.toml"
            local content = [[
                [package]
                name = "leetcode"
                edition = "2024"

                [lib]
                name = "%s"
                path = "%s"
              ]]

            local file = io.open(problem_dir, "w")
            if file then
              local formatted = (content:gsub(" +", "")):format(question.q.frontend_id, question:path())
              file:write(formatted)
              file:close()
            else
              print("Failed to open file: " .. problem_dir)
            end
          end,
        },
      },
      injector = {
        ["cpp"] = {
          before = { "#include <bits/stdc++.h>", "using namespace std;" },
        },
        ["rust"] = {
          before = { "fn main(){}", "struct Solution;" },
        },
      },
    },
  },
}
