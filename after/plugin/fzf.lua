local fzf_ok, fzf = pcall(require, "fzf-lua")
if not fzf_ok then
    return
end

if fzf_ok then
    fzf.setup({
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
                    ["png"] = { "viu", "-b" },
                    ["jpg"] = { "viu", "-b" },
                    ["jpeg"] = { "viu", "-b" },
                },
            },
        },
    })
end
