local get_root_dir = require("null-ls.utils").root_pattern("build.sh", ".null-ls-root", "Makefile", ".git")
local root_dir = get_root_dir(vim.fn.getcwd())

if root_dir ~= nil then
    local Makefile_path = root_dir .. "/Makefile"
    local build_sh_path = root_dir .. "/build.sh"
    if vim.fn.filereadable(Makefile_path) == 1 then
        vim.opt.makeprg = "make"
    elseif vim.fn.filereadable(build_sh_path) == 1 then
        vim.opt.makeprg = "sh build.sh"
    end
else
    vim.opt.makeprg = "c++ -Wall -Wextra -ggdb %:p:h/*.cpp -o main && ./main"
end
