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
        lang = "rust",

        plugins = {
            non_standalone = true,
        },
        injector = {
            ["python3"] = {
                before = true,
            },
            ["cpp"] = {
                before = { "#include <bits/stdc++.h>", "using namespace std;" },
            },
        },
        hooks = {
            ["question_enter"] = {
                function()
                    if vim.fn.expand("%:e") == "rs" then
                        local crates = ""
                        local next = ""
                        for f in io.popen("ls *.rs"):lines() do
                            crates = crates
                                .. next
                                .. string.format('{"root_module": "%s","edition": "2021","deps": []}', f)
                            next = ","
                        end

                        local sysroot_src = io.popen("rustc --print sysroot"):read("*a"):gsub("\n", "")
                            .. "/lib/rustlib/src/rust/library"

                        local rust_project_json =
                            string.format('{"sysroot_src": "%s", "crates": [%s]}', sysroot_src, crates)
                        local success, error_message = pcall(function()
                            local file = io.open(vim.fn.stdpath("data") .. "/leetcode/rust-project.json", "w")
                            file:write(rust_project_json)
                            file:close()
                        end)

                        if success then
                            print("Successfully updated rust-project.json")
                            vim.defer_fn(function()
                                vim.cmd("LspRestart rust_analyzer")
                            end, 1000)
                        else
                            print(string.format("Failed update rust-project.json. Error: %s", error_message))
                        end
                    end
                end,
            },
        },
    },
}
