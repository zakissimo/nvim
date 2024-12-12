local root_dir = vim.fs.dirname(vim.fs.find({ "build.sh", "Makefile", ".git" }, { upward = true })[1])

if root_dir ~= nil then
  local Makefile_path = root_dir .. "/Makefile"
  local build_sh_path = root_dir .. "/build.sh"
  if vim.fn.filereadable(Makefile_path) == 1 then
    vim.opt.makeprg = "make"
  elseif vim.fn.filereadable(build_sh_path) == 1 then
    vim.opt.makeprg = "sh build.sh"
  end
else
  vim.opt.makeprg = "cc -Wall -Wextra -ggdb %:p:h/*.c -o main && ./main"
end
