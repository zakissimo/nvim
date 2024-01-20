require("fzf-lua").setup({
    winopts = {
        hl = {
            border = "rounded",
        },
    },
    files = {
        cmd = "rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null",
    },
    previewers = {
        builtin = {
            extensions = {
                -- neovim terminal only supports `viu` block output
                ["png"] = { "chafa", "-f", "sixels" },
                ["jpg"] = { "chafa", "-f", "sixels" },
                ["jpeg"] = { "chafa", "-f", "sixels" },
            },
        },
    },
})
