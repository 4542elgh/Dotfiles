-- ALL FUNCTION NEED TO BE FUNCTIONAL FUNCTION WITHOUT SIDE EFFECTS
-- This way we dont create inconsistency with global variables
--================================================================================
--     ____  ___   ________ __ __________ 
--    / __ \/   | / ____/ //_// ____/ __ \
--   / /_/ / /| |/ /   / ,<  / __/ / /_/ /
--  / ____/ ___ / /___/ /| |/ /___/ _, _/ 
-- /_/   /_/  |_\____/_/ |_/_____/_/ |_|  
--================================================================================
function packer_bootstrap()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

--================================================================================
--     ________  ___   ______________________  _   _______
--    / ____/ / / / | / / ____/_  __/  _/ __ \/ | / / ___/
--   / /_  / / / /  |/ / /     / /  / // / / /  |/ /\__ \ 
--  / __/ / /_/ / /|  / /___  / / _/ // /_/ / /|  /___/ / 
-- /_/    \____/_/ |_/\____/ /_/ /___/\____/_/ |_//____/  
--================================================================================
----------------------------------------------------------------------------------
-- Just some helper functions making setup less repetitive
----------------------------------------------------------------------------------
function imap(left,right)
    vim.keymap.set('i', left, right)
end

function nmap(left,right)
    vim.keymap.set('n', left, right)
end

function vmap(left,right)
    vim.keymap.set('v', left, right)
end

function tnoremap(left,right)
    vim.keymap.set('t', left, right, { noremap = true })
end

function abbrev(short, expand)
    vim.cmd('cnoreabbrev ' .. short .. ' ' .. expand)
end

function executable(name)
    return vim.fn.executable(name) == 1
end

function autocmd(mode, ext, cmd)
    vim.api.nvim_create_autocmd(mode,{
        pattern = ext,
        command = cmd
    })
end

function substr(string, beginIndex, length)
    -- sub string begin with index one and follow up with length
    return string.sub(string, beginIndex, length)
end

function getVisualRange()
    local srtRow = vim.api.nvim_buf_get_mark(0,"<")[1]
    local endRow = vim.api.nvim_buf_get_mark(0,">")[1]
    return srtRow, endRow
end

--================================================================================
--     ____  __________  _____ ____  _   _____    __ 
--    / __ \/ ____/ __ \/ ___// __ \/ | / /   |  / / 
--   / /_/ / __/ / /_/ /\__ \/ / / /  |/ / /| | / /  
--  / ____/ /___/ _, _/___/ / /_/ / /|  / ___ |/ /___
-- /_/   /_____/_/ |_|/____/\____/_/ |_/_/  |_/_____/
--================================================================================
----------------------------------------------------------------------------------
-- Generate a sequence of numbers based on interactive input
----------------------------------------------------------------------------------
function hostname()
    if vim.g.is_windows then
        local hostnameAddr = vim.fn.system("cmd /C hostname")
        for host in hostnameAddr:gmatch("[^\r\n]+") do
            return host
        end
    end
end

function gen()
    local beginRange = vim.fn.input("Begin Range: ")
    local endRange = vim.fn.input("End Range: ")
    local prefix = vim.fn.input("Prefix: ")
    local suffix = vim.fn.input("Suffix: ")

    vim.cmd("silent for i in range(" .. beginRange .. "," .. endRange .. ") | put ='" .. prefix .. "'.i.'" .. suffix .. "' | endfor | -" .. (endRange - beginRange) )
end

-- Reverse selected order
function reverse()
    local srtIdx, endIdx = getVisualRange()
    vim.cmd(srtIdx .. ',' .. endIdx .. 'g/^/m' .. srtIdx-1 .. '<CR>')
end

function ssh()
    local user = vim.fn.input("SSH user name: ")
    local server = vim.fn.input("SSH server: ")
    local path = vim.fn.input("SSH Remote absolute path: ")
    vim.cmd("e scp://" .. user .. "@" .. server .. "/" .. path)
end

function concatPath(arr, concatChar, prefixChar, suffixChar)
    local result = ""
    if prefixChar then result = result .. concatChar end
    for count, item in ipairs(arr) do
        if(count ~= #arr) then
            result = result .. item .. concatChar
        else
            result = result .. item
        end
    end
    if suffixChar then result = result .. concatChar end
    return result
end

function networkPath()
    local drive = string.upper(vim.fn.input("Drive Letter: ", "")) .. ":"
    local output = vim.fn.system("cmd /C net use")
    local found = false

    for line in output:gmatch("%S+") do
        if found == true then
            vim.fn.setreg("\"", line)
            break
        end
        if line == drive then
            found = true
        end
    end
end
