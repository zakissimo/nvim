local build_files = { "build.sh", "Makefile", "CMakeLists.txt" }

local root_dir = vim.fs.dirname(vim.fs.find(build_files, { upward = true, type = "file" })[1])
local build_dir = vim.fs.dirname(vim.fs.find({ "build" }, { upward = true, type = "directory" })[1])

vim.keymap.set("n", "<M-o>", "<CMD>LspClangdSwitchSourceHeader<CR>", { silent = true })

local function build(file, parent_dir)
  if file == "build.sh" then
    return string.format("sh %s/build.sh build %s", parent_dir, vim.fn.expand("%:t"))
  end
  if file == "Makefile" then
    return string.format("make -C %s", parent_dir)
  end
  if file == "CMakeLists.txt" then
    local dir = parent_dir .. "/build"
    local up_build_dir = parent_dir .. "/../build"
    if vim.fn.isdirectory(dir) ~= 1 and vim.fn.isdirectory(up_build_dir) ~= 1 then
      vim.fn.system(string.format("cmake -S . -B %s", dir))
    elseif vim.fn.isdirectory(up_build_dir) == 1 then
      dir = up_build_dir
    end
    return string.format("make -C %s", dir)
  end
end

local function find(dir)
  for _, build_file in pairs(build_files) do
    local build_file_path = string.format("%s/%s", dir, build_file)
    if vim.fn.filereadable(build_file_path) == 1 then
      vim.opt.makeprg = build(build_file, dir)
      break
    end
  end
end

if root_dir ~= nil then
  find(root_dir)
elseif build_dir ~= nil then
  find(string.format("%s/build", build_dir))
else
  vim.opt.makeprg =
    "c++ -std=c++20 -Wall -Wextra -O0 -fno-elide-constructors -ggdb -fsanitize=address,undefined,leak -D_GLIBCXX_DEBUG %:p:h/*.cpp -o main"
end
