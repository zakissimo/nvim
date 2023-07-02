local ls = require("luasnip")

local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local getFileName = function()
    return vim.fn.expand("%:t:r")
end

ls.add_snippets("cpp", {
    s(
        {
            trig = "ocf",
            snippetType = "autosnippet",
        },
        fmt([[
        class {className} {{

          public:
            {className}();
            ~{className}();
            {className}(const {className}& other);
            {className}& operator=(const {className}& other);

        }};
        ]], {
                className = f(getFileName, {})
            }, {
                repeat_duplicates = true
            })
    ),
})
