-- local ls = require("luasnip")
--
-- local snip = ls.snippet
-- local text = ls.text_node
-- local func = ls.function_node
-- local insert = ls.insert_node
-- local indent = ls.indent_node
-- local fmt = require("luasnip.extras.fmt").fmt
-- local node = ls.snippet_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- local getFileName = function()
--     return vim.fn.expand("%:t:r")
-- end
--
-- ls.add_snippets(nil, {
--     cpp = {
--         snip(
--             {
--                 trig = "fuk",
--             },
--             fmt(
--                 [[
--             class {f}{
--               public:
--                 {f}();
--                 {f}(const {f}& other);
--                 {f}& operator=(const {f}& other);
--                 ~{f}();
--             };
--             ]],
--                 { f = func(getFileName, {}), repeat_duplicates = true }
--             )
--         ),
--     },
-- })
ls.add_snippets("all", {
  -- important! fmt does not return a snippet, it returns a table of nodes.
  s("example1", fmt("just an {iNode1}", {
    iNode1 = i(1, "example")
  })),
  s("example2", fmt([[
  if {} then
    {}
  end
  ]], {
    -- i(1) is at nodes[1], i(2) at nodes[2].
    i(1, "not now"), i(2, "when")
  })),
  s("example3", fmt([[
  if <> then
    <>
  end
  ]], {
    -- i(1) is at nodes[1], i(2) at nodes[2].
    i(1, "not now"), i(2, "when")
  }, {
    delimiters = "<>"
  })),
  s("example4", fmt([[
  repeat {a} with the same key {a}
  ]], {
    a = i(1, "this will be repeat")
  }, {
    repeat_duplicates = true
  }))
})
