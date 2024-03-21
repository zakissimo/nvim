local build_files = { "build.sh", "Makefile", "CMakeLists.txt" }

local root_dir = vim.fs.dirname(vim.fs.find(build_files, { upward = true })[1])

local M = {}

M.build = function(file)
    if file == "build.sh" then
        return "sh build.sh"
    end
    if file == "Makefile" then
        return "make"
    end
    if file == "CMakeLists.txt" then
        return "make"
    end
end

if root_dir ~= nil then
    for _, build_file in pairs(build_files) do
        local build_file_path = root_dir .. build_file
        if vim.fn.filereadable(build_file_path) == 1 then
            vim.opt.makeprg = M.build(build_file)
        end
    end
else
    vim.opt.makeprg = "c++ -Wall -Wextra -ggdb %:p:h/*.cpp -o main && ./main"
end
