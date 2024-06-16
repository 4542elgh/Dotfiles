if vim.fn.executable('neovim') == 0 and vim.fn.executable('npm') == 1 then
    os.execute("npm install -g neovim")
end

if (vim.fn.executable('python -m neovim') == 0 or vim.fn.executable('python -m pynvim') == 0) and vim.fn.executable('python') == 1 then
    os.execute("python -m pip install neovim")
    os.execute("python -m pip install pyvim")
end
