local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

local mason_langs = {}
local raw_lang_data = require("mason-registry").get_installed_packages()
for _, lang in pairs(raw_lang_data) do
    for key, value in pairs(lang) do
        if key == "spec" then
            mason_langs = vim.tbl_deep_extend("force", mason_langs, value.languages)
        end
    end
end

local hash = {}
local langs = {}
for _, v in ipairs(mason_langs) do
    if not hash[v] then
        langs[#langs + 1] = v:lower()
        hash[v] = true
    end
end

configs.setup({
    ensure_installed = langs, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        -- use_languagetree = true,
        enable = true, -- false will disable the whole extension
        -- disable = { "css", "html" }, -- list of language that will be disabled
        disable = { "css" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autotag = {
        enable = true,
        disable = { "xml" },
    },
    rainbow = {
        enable = true,
        colors = {
            "Gold",
            "Orchid",
            "DodgerBlue",
            "Cornsilk",
            -- "Salmon",
            -- "LawnGreen",
        },
        disable = { "html" },
    },
    playground = {
        enable = true,
    },
})
