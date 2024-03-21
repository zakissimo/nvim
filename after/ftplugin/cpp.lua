local build_files = { "build.sh", "Makefile", "CMakeLists.txt" }

local root_dir = vim.fs.dirname(vim.fs.find(build_files, { upward = true })[1])

local M = {}

M.build = function(file)
    if file == "build.sh" then
        return string.format("sh %s/build.sh", root_dir)
    end
    if file == "Makefile" then
        return string.format("make -C %s", root_dir)
    end
    if file == "CMakeLists.txt" then
        local build_dir = root_dir .. "/build"
        local up_build_dir = root_dir .. "/../build"
        if vim.fn.isdirectory(build_dir) ~= 1 and vim.fn.isdirectory(up_build_dir) ~= 1 then
            vim.fn.system(string.format("cmake -S . -B %s", build_dir))
        elseif vim.fn.isdirectory(up_build_dir) == 1 then
            build_dir = up_build_dir
        end
        return string.format("make -C %s", build_dir)
    end
end

if root_dir ~= nil then
    for _, build_file in pairs(build_files) do
        local build_file_path = string.format("%s/%s", root_dir, build_file)
        if vim.fn.filereadable(build_file_path) == 1 then
            vim.opt.makeprg = M.build(build_file)
            break
        end
    end
else
    vim.opt.makeprg = "c++ -Wall -Wextra -ggdb %:p:h/*.cpp -o main && ./main"
end
