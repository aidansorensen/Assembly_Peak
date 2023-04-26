-- local assemblypeek = require("assemblypeek")
local popup = require("plenary.popup")
local M = {}

asmpeek_win_id = nil
asmpeek_bufh = nil


local function close_menu(force_save)
    force_save = force_save or false
    -- local global_config = harpoon.get_global_settings()

    -- if global_config.save_on_toggle or force_save then
    --     require("assemblypeek.ui").on_menu_save()
    -- end

    vim.api.nvim_win_close(asmpeek_win_id, true)

    asmpeek_win_id = nil
    asmpeek_bufh = nil
end


local function create_window()
    -- local width = config.width or 60
    -- local height = config.height or 10
    
    local width = 60
    local height = 10
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    local bufnr = vim.api.nvim_create_buf(false, false)
    
    local asmpeek_win_id, win = popup.create(bufnr, {
        title = "Peek at Assembly",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
    })

    return {
        bufnr = bufnr,
        win_id = asmpeek_win_id,
    }
end


function M.toggle_quick_menu()
    -- log.trace("toggle_quick_menu()")
    if asmpeek_win_id ~= nil and vim.api.nvim_win_is_valid(asmpeek_win_id) then
        close_menu()
        return
    end

    -- local curr_file = utils.normalize_path(vim.api.nvim_buf_get_name(0))
    -- vim.cmd(
    --     string.format(
    --         "autocmd Filetype harpoon "
    --             .. "let path = '%s' | call clearmatches() | "
    --             -- move the cursor to the line containing the current filename
    --             .. "call search('\\V'.path.'\\$') | "
    --             -- add a hl group to that line
    --             .. "call matchadd('HarpoonCurrentFile', '\\V'.path.'\\$')",
    --         curr_file:gsub("\\", "\\\\")
    --     )
    -- )

    local win_info = create_window()
    local contents = {}
    -- local global_config = harpoon.get_global_settings()


    asmpeek_win_id = win_info.win_id
    asmpeek_bufh = win_info.bufnr

    -- for idx = 1, Marked.get_length() do
    --     local file = Marked.get_marked_file_name(idx)
    --     if file == "" then
    --         file = "(empty)"
    --     end
    --     contents[idx] = string.format("%s", file)
    -- end

    vim.api.nvim_win_set_option(asmpeek_win_id, "number", true)
    vim.api.nvim_buf_set_name(asmpeek_bufh, "harpoon-menu")
    vim.api.nvim_buf_set_lines(asmpeek_bufh, 0, #contents, false, contents)
    vim.api.nvim_buf_set_option(asmpeek_bufh, "filetype", "harpoon")
    vim.api.nvim_buf_set_option(asmpeek_bufh, "buftype", "acwrite")
    vim.api.nvim_buf_set_option(asmpeek_bufh, "bufhidden", "delete")
    vim.api.nvim_buf_set_keymap(
        asmpeek_bufh,
        "n",
        "q",
        "<Cmd>lua require('assemblypeek.ui').toggle_quick_menu()<CR>",
        { silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        asmpeek_bufh,
        "n",
        "<ESC>",
        "<Cmd>lua require('assemblypeek.ui').toggle_quick_menu()<CR>",
        { silent = true }
    )
    -- vim.api.nvim_buf_set_keymap(
    --     asmpeek_bufh,
    --     "n",
    --     "<CR>",
    --     "<Cmd>lua require('assemblypeek.ui').select_menu_item()<CR>",
    --     {}
    -- )
    -- vim.cmd(
    --     string.format(
    --         "autocmd BufWriteCmd <buffer=%s> lua require('harpoon.ui').on_menu_save()",
    --         Harpoon_bufh
    --     )
    -- )
    -- if global_config.save_on_change then
    --     vim.cmd(
    --         string.format(
    --             "autocmd TextChanged,TextChangedI <buffer=%s> lua require('harpoon.ui').on_menu_save()",
    --             Harpoon_bufh
    --         )
    --     )
    -- end
    -- vim.cmd(
    --     string.format(
    --         "autocmd BufModifiedSet <buffer=%s> set nomodified",
    --         Harpoon_bufh
    --     )
    -- )
    vim.cmd(
        "autocmd BufLeave <buffer> ++nested ++once silent lua require('assemblypeek.ui').toggle_quick_menu()"
    )
end

return M
