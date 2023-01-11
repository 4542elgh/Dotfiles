require("util")
require("global")
require("abbrev")
require("autoload")
require("mapping")
-- require("packers") 
require("lazycore")

local function cmd(alias, command)
    return vim.api.nvim_create_user_command(alias, command, {nargs = 0})
end

cmd(
    'Search',
    function ()
        local search = vim.fn.input("Search: ")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local searcher = function(opts)
            opts = opts or {}
            pickers.new(opts, {
                prompt_title = "OmniSearch",
                finder = finders.new_table {
                    results = {
                        { 'Stack Overflow', ('www.stackoverflow.com/search\\?q\\=' .. search:gsub(' ', '+')) },
                        { 'Google Search', ('www.google.com/search?q=' .. search:gsub(' ', '+')) },
                        { 'Youtube', ('https://www.youtube.com/results\\?search_query\\=' .. search:gsub(' ', '+')) },
                        { 'Wikipedia', ('https://en.wikipedia.org/w/index.php\\?search\\=' .. search:gsub(' ', '+')) },
                        { 'Github', ('https://github.com/search\\?q\\=' .. search:gsub(' ', '+')) },
                    },
                    entry_maker = function(entry)
                        return {value = entry, display = entry[1], ordinal = entry[1]}
                    end
                },
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        vim.cmd(("silent execute '!msedge %s'"):format(selection['value'][2]))
                    end)
                    return true
                end,
            }):find()
        end
        searcher(require("telescope.themes").get_dropdown({}))
    end
)
