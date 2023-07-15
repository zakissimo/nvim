local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    }),
    ["<C-j>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-l>"] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        fallback()
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        fallback()
    end, { "i", "s" }),
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
local lspkind = require("lspkind")
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        col_offset = -3,
        side_padding = 0,
    },
    mapping = cmp_mappings,
    formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
            local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = { Copilot = "" } })(
                entry,
                vim_item
            )
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = ""
            return kind
        end,
    },
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp", max_item_count = 7 },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip", max_item_count = 5 },
        { name = "path" },
    }),
})

require("cmp").setup.cmdline({ "?", "/" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
    }, {
        { name = "buffer" },
    }),
})

require("cmp").setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})
