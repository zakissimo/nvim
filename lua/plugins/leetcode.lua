return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        lang = "cpp",

        plugins = {
            non_standalone = true,
        },
        injector = {
            ["python3"] = {
                before = true,
            },
            ["cpp"] = {
                before = { "#include <bits/stdc++.h>", "using namespace std;" },
                after = "int main() {}",
            },
        },
        hooks = {
            ["question_enter"] = {
                function()
                    local file_extension = vim.fn.expand("%:e")
                    if file_extension == "rs" then
                        local script = string.format("%s/leetcode/rust_init", tostring(vim.fn.stdpath("data")))
                        local success, error_message = os.execute(script)
                        if success then
                            print("Successfully updated rust-project.json")
                            vim.cmd("LspRestart rust_analyzer")
                        else
                            print(string.format("Failed update rust-project.json. Error: %s", error_message))
                        end
                    end
                end,
            },
        },
    },
}
