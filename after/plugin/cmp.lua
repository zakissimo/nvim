local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local types_ok, types = pcall(require, "cmp.types")
if not types_ok then
    return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
    return
end

luasnip.config.setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()

local mapping = {
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-c>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),
    ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
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
    ["<Tab>"] = cmp.config.disable,
    ["<S-Tab>"] = cmp.config.disable,
}

local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = "rounded",
            winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
            col_offset = -3,
            side_padding = 1,
            scrollbar = false,
        },
        documentation = {
            border = "rounded",
            scrollbar = false,
            winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
        },
    },
    mapping = mapping,
    formatting = {
        fields = { "abbr", "kind" },
        format = function(entry, vim_item)
            vim_item.menu = ""
            local kind = lspkind.cmp_format({
                maxwidth = 50,
            })(entry, vim_item)
            return kind
        end,
    },
    completion = {
        autocomplete = {
            types.cmp.TriggerEvent.TextChanged,
            types.cmp.TriggerEvent.InsertEnter,
        },
        completeopt = "menuone,noinsert,preview",
        keyword_length = 1,
    },
    matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = true,
    },
    performance = {
        debounce = 0,
        throttle = 0,
        fetching_timeout = 500,
        confirm_resolve_timeout = 500,
        async_budget = 10,
        max_view_entries = 50,
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.scopes,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 1, priority = 100 },
        { name = "path", keyword_length = 0, priority = 110 },
        { name = "luasnip", keyword_length = 2, priority = 120 },
    }),
})

cmp.setup.cmdline({ "?", "/" }, {
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }, {
        { name = "cmdline_history" },
    }),
})
