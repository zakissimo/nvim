local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
    return
end

luasnip.config.setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()

local autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if autopairs_ok then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local select = { behavior = cmp.SelectBehavior.Select }
local mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(select),
    ["<C-n>"] = cmp.mapping.select_next_item(select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
    }),
    ["<M-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
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
    ["<Tab>"] = cmp.config.disable,
    ["<S-Tab>"] = cmp.config.disabe,
}

local lspkind = require("lspkind")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        col_offset = -3,
        side_padding = 0,
    },
    mapping = mapping,
    formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
                symbol_map = {
                    Copilot = "",
                    Cody = "",
                },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = ""
            return kind
        end,
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
        },
    },
    sources = cmp.config.sources({
        { name = "cody" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
    }),
})

local cmdline_mapping = cmp.mapping.preset.cmdline({
    ["<C-p>"] = cmp.mapping.select_prev_item(select),
    ["<C-n>"] = cmp.mapping.select_next_item(select),
})

require("cmp").setup.cmdline({ "?", "/" }, {
    mapping = cmdline_mapping,
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
    }, {
        { name = "buffer" },
    }),
})

require("cmp").setup.cmdline(":", {
    mapping = cmdline_mapping,
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }, {
        { name = "cmdline_history" },
    }),
})
