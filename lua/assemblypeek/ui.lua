-- local assemblypeek = require("assemblypeek.utils")
local popup = require("plenary.popup")
local M = {}

asmpeek_win_id = nil
asmpeek_bufh = nil

contents = {"fizzbuzz::fizz", "fizzbuzz::main"}

local function close_menu(force_save)
    force_save = force_save or false

    vim.api.nvim_win_close(asmpeek_win_id, true)

    asmpeek_win_id = nil
    asmpeek_bufh = nil
end


local function create_window()
    
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

    local win_info = create_window()

    asmpeek_win_id = win_info.win_id
    asmpeek_bufh = win_info.bufnr


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
    vim.api.nvim_buf_set_keymap(
        asmpeek_bufh,
        "n",
        "<CR>",
        "<Cmd>lua require('assemblypeek.ui').select_menu_item()<CR>",
        {}
    )
    vim.cmd(
        "autocmd BufLeave <buffer> ++nested ++once silent lua require('assemblypeek.ui').toggle_quick_menu()"
    )
end

function M.select_menu_item()
    local idx = vim.fn.line(".")
    close_menu(true)
    print(idx)
    require('assemblypeek.utils').show_assembly(contents[idx])
end



return M
