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

local mapping = {
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-o>"] = cmp.mapping.complete(),
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
                    Codeium = "",
                },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = ""
            return kind
        end,
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            -- deprioritize `.box`, `.mut`, etc.
            require("cmp-rust").deprioritize_postfix,
            -- deprioritize `Borrow::borrow` and `BorrowMut::borrow_mut`
            require("cmp-rust").deprioritize_borrow,
            -- deprioritize `Deref::deref` and `DerefMut::deref_mut`
            require("cmp-rust").deprioritize_deref,
            -- deprioritize `Into::into`, `Clone::clone`, etc.
            require("cmp-rust").deprioritize_common_traits,
            cmp.config.compare.offset,
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
        { name = "codeium" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "spell", max_item_count = 2, option = { keyword_pattern = [[\k\+]] } },
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
